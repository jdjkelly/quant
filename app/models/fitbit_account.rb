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

  data_provider_for :weights, :sleeps, :meals

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

    weights = client.body_weight options
    process_weights user.weights.create weights[:weight]
  end

  def sleeps options={}
    # sleeps = client.sleeps(options)
    # process_sleeps user.sleeps.create sleeps[:sleep.to_s]

    raise Exceptions::NotImplemented
  end

  def meals options={}
    # meals = client.recent_foods
    # process_sleeps user.meals.create meals[:meal.to_s]

    raise Exceptions::NotImplemented
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
    weights.each do |weight|
      next if user.weights.where("meta @> 'logId=>#{weight[:logId.to_s].to_s}").first
      user.weights.create(
        value: Unit.new(measurement.weight, :pounds).to(:pounds),
        date: weight[:date.to_s],
        source: "FitbitAccount",
        meta: {
          logId: weight[:logId.to_s]
        }
      )
    end
  end

  def process_sleeps sleeps
    raise Exceptions::NotImplemented
  end

  def process_meals meals
    raise Exceptions::NotImplemented
  end
end
