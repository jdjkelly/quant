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

  data_provider_for :weights, :sleeps

  def weights options={}
    # TODO: Add support for data /since/ synced_at,
    # data for all time, and splitting both over multiple
    # requests
    options[:base_date] = "today"
    options[:period] = "1m"

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
