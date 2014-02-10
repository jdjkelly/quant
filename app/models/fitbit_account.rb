# == Schema Information
#
# Table name: fitbit_accounts
#
#  id                 :integer          not null, primary key
#  uid                :string(255)
#  oauth_token        :string(255)
#  oauth_token_secret :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  synced_at          :datetime
#  activated_at       :datetime
#

class FitbitAccount < ActiveRecord::Base
  include DataProvider

  attr_accessible :uid, :oauth_token, :oauth_token_secret, :user

  validates_presence_of :uid, :oauth_token, :oauth_token_secret

  data_provider_for :weights, :sleeps

  def weights options={}
    if options[:import] == true && self.activated_at.present?
      weights_since self.activated_at, options.except(:import)
      return
    elsif options[:sync] == true && self.synced_at.present?
      weights_since self.synced_at, options.except(:sync)
      return
    end

    # TODO: This needs to be wrapped in an external API rescue so that
    # failures are handled gracefully
    response = client.body_weight({ base_date: Date.current, period: "30d" }.merge(options).except(:sync, :import))
    process_weights response["weight"]
  end

  def weights_since date, options={}
    while date < Date.current
      date += 30.days
      weights({ base_date: date, period: "30d" }.merge(options))
    end
  end

  def sleeps options={}
    if options[:import] == true
      sleeps_since Date.current, options.merge({ period: "max" })
    elsif options[:sync] == true && self.synced_at.present?
      sleeps_since self.synced_at, options.merge({ end_date: Date.current })
    else
      options = { base_date: Date.current}.merge(options)
      response = client.sleep_on_date(options[:base_date])
      process_sleeps response["sleep"]
    end
  end

  def sleeps_since date, options={}
    raise ArgumentError unless options[:period].present? || options[:end_date].present?

    sleeps = client.data_by_time_range("/sleep/startTime", { base_date: date }.merge(options))
    sleeps = sleeps["sleep-startTime"].select{|sleep| !sleep["value"].empty?}
    sleeps.each do |sleep|
      sleeps({ base_date: Date.parse(sleep["dateTime"]) }.merge(options).except(:sync, :import))
    end
  end

  def time_zone
    user_info["timezone"] if user_info.present?
  end

  private

  def client
    FitbitAccount.authenticated_user self.id
  end

  def self.authenticated_user id
    user = FitbitAccount.find id
    Fitgem::Client.new({
      consumer_key: Settings.fitbit_oauth_key,
      consumer_secret: Settings.fitbit_oauth_secret,
      token: user.oauth_token,
      secret: user.oauth_token_secret,
      unit_system: Fitgem::ApiUnitSystem.METRIC
    })
  end

  def process_weights weights
    raise ArgumentError "weights must be an array" unless weights.is_a? Array || weights.nil?

    weights.each do |weight|
      next if user.weights.where("meta @> 'logId=>#{weight[:logId.to_s].to_s}'").first
      user.weights.create(
        value: weight["weight"],
        date: Time.use_zone(time_zone) { Time.zone.parse("#{weight["date"]} #{weight["time"]}") }, #TODO: Timezone?
        source: self.class.to_s,
        meta: {
          logId: weight["logId"],
          response: weight
        }
      )
    end
  end

  def process_sleeps sleeps
    raise ArgumentError "sleeps must be an array" unless sleeps.is_a? Array || sleeps.nil?

    sleeps.each do |sleep|
      next if user.sleeps.where("meta @> 'logId=>#{sleep[:logId.to_s].to_s}'").first
      start = Time.use_zone(time_zone) { Time.zone.parse(sleep["startTime"]) }
      user.sleeps.create(
        start: start,
        end: start + sleep["timeInBed"].to_i.minutes,
        source: self.class.to_s,
        meta: {
          logId: sleep["logId"],
          response: sleep
        }
      )
    end
  end

  def user_info
    @user_info ||= client.user_info["user"]
  end
end
