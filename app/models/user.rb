# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  encrypted_password :string(128)
#  salt               :string(128)
#  confirmation_token :string(128)
#  remember_token     :string(128)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ActiveRecord::Base
  scope :published, where(:published => true)

  has_many :measurements
  has_many :fat_masses
  has_many :fat_percentages
  has_many :lean_masses
  has_many :weights
  has_one :withings_account

  def weight
    self.weights.current
  end

  def fat_mass
    self.fat_masses.current
  end

  def fat_percentage
    self.fat_percentages.current
  end

  def lean_mass
    self.lean_masses.current
  end
end
