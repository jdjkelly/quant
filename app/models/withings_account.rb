# == Schema Information
#
# Table name: withings_accounts
#
#  id                 :integer          not null, primary key
#  userid             :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  oauth_token        :string(255)
#  oauth_verifier     :string(255)
#  user_id            :integer
#  oauth_token_secret :string(255)
#

class WithingsAccount < DataProvider
  attr_accessible :userid, :oauth_token, :oauth_token_secret

  validates_presence_of :userid, :oauth_token, :oauth_token_secret

  def get_user_data
    WithingsAccount.authenticated_user(id).measurement_groups.each do |measurement|
      user.weights.create(
        value: Unit.new(measurement.weight, :kilograms).to(:pounds),
        recorded_at: measurement.taken_at,
        fat_mass_value: Unit.new(measurement.fat, :kilograms).to(:pounds),
        source: "WithingsAccount",
        meta: {
          grpid: measurement.grpid.to_s
        }
      )
    end
  end

  def self.authenticated_user id
    user = WithingsAccount.find id
    Withings::User.authenticate(user.userid, user.oauth_token, user.oauth_token_secret)
  end
end
