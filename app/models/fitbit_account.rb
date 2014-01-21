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
#

class FitbitAccount < ActiveRecord::Base
  include DataProvider

  attr_accessible :uid, :oauth_token, :oauth_token_secret

  validates_presence_of :uid, :oauth_token, :oauth_token_secret

  data_provider_for :weights

  def weights options={}
    options[:start_date] = synced_at if synced_at

    if options[:start_date].present? && options[:end_date].present?
      if options[:end].in_days - options[:start].in_days > 31
        raise Exceptions::OutOfRange
      end
    elsif options[:start_date].present?
      raise Exceptions::NotImplemented "We need to handle the case of a synced_at
        date > 30 days ago - and then recursively gather data in 31 day blocks"
    else
      options[:base_date] = "today"
      options[:period] = "1m"
    end

    response = client.body_weight options
    process_weights response["weight"]
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
      secret: user.oauth_token_secret
    })
  end

  def process_weights weights
    raise ArgumentError "weights must be an array" unless weights.is_a? Array || weights.nil?

    weights.each do |weight|
      next if user.weights.where("meta @> 'logId=>#{weight[:logId.to_s].to_s}'").first
      user.weights.create(
        value: Unit.new(weight["weight"], :pounds).to(:pounds),
        date: Time.parse("#{weight["date"]} #{weight["time"]}"),
        source: "FitbitAccount",
        meta: {
          logId: weight["logId"]
        }
      )
    end
  end
end
