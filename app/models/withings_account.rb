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
    Withings::User.authenticate(userid, oauth_token, oauth_token_secret).measurement_groups.each do |measurement|
      user.weights.create(
        value: Unit.new(measurement.weight, :kilograms).to(:pounds).round(1),
        recorded_at: measurement.taken_at,
        fat_mass_value: Unit.new(measurement.fat, :kilograms).to(:pounds).round(1)
      )
    end
  end
end
