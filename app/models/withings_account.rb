# == Schema Information
#
# Table name: withings_accounts
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WithingsAccount < ActiveRecord::Base
  attr_accessible :userid, :oauth_token, :oauth_verifier, :oauth_token_secret

  belongs_to :user

  before_create :get_user_data

  # protected

  def get_user_data
    WithingsAccount.authenticated_user(id).measurement_groups.each do |measurement|
      user.weights.create(
        grpid: measurement.grpid,
        value: Unit.new(measurement.weight, :kilograms).to(:pounds),
        recorded_at: measurement.taken_at,
        fat_mass_value: Unit.new(measurement.fat, :kilograms).to(:pounds)
      )
    end
  end

  def self.authenticated_user id
    user = WithingsAccount.find id
    Withings::User.authenticate(user.userid, user.oauth_token, user.oauth_token_secret)
  end
end
