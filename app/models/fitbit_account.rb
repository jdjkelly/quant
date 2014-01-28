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

  attr_accessible :uid, :oauth_token, :oauth_token_secret

  validates_presence_of :uid, :oauth_token, :oauth_token_secret

  data_provider_for :weights

  def weights options={}
    if options[:import] == true && self.activated_at.present?
      weights_since self.activated_at, options.except(:import)
      return
    elsif options[:sync] == true && self.synced_at.present?
      options = {
        base_date: "today",
        period: "1m"
      } if options.nil?
      weights_since self.synced_at, options.except(:sync)
      return
    end

    # TODO: This needs to be wrapped in an external API rescue so that
    # failures are handled gracefully
    response = client.body_weight options.except(:sync, :import)
    process_weights response["weight"]
  end

  def weights_since date=Date.current, options={}
    while date < Date.current
      date += 30.days
      weights({ base_date: date, period: "30d" }.merge(options))
    end
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
        date: Time.parse("#{weight["date"]} #{weight["time"]}"),
        source: "FitbitAccount",
        meta: {
          logId: weight["logId"]
        }
      )
    end
  end
end
