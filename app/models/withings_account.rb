# == Schema Information
#
# Table name: withings_accounts
#
#  id                 :integer          not null, primary key
#  userid             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  oauth_token        :string(255)
#  user_id            :integer
#  oauth_token_secret :string(255)
#  synced_at          :datetime
#  activated_at       :datetime
#

class WithingsAccount < ActiveRecord::Base
  include DataProvider

  attr_accessible :userid, :oauth_token, :oauth_token_secret

  validates_presence_of :userid, :oauth_token, :oauth_token_secret

  data_provider_for :weights

  def weights options={}
    if options[:sync] == true && self.synced_at.present?
      weights_since self.synced_at, options.except(:sync)
      return
    end

    # TODO: This needs to be wrapped in an external API rescue so that
    # failures are handled gracefully
    response = client.send(:measurement_groups, options)
    process_weights response
  end

  def weights_since date=Date.current, options={}
    weights({ start_at: date }.merge(options))
  end

  private

  def client
    WithingsAccount.authenticated_user(id)
  end

  def self.authenticated_user id
    user = WithingsAccount.find id
    Withings::User.authenticate(user.userid, user.oauth_token, user.oauth_token_secret)
  end

  def process_weights weights
    weights.each do |weight|
      next if user.weights.where("meta @> 'grpid=>#{weight.grpid.to_s}'").first
      user.weights.create(
        value: weight.weight,
        date: weight.taken_at,
        fat_mass: weight.fat,
        source: "WithingsAccount",
        meta: {
          grpid: weight.grpid.to_s
        }
      )
    end
  end
end
