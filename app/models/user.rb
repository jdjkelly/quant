# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  name                   :string(255)
#  height                 :decimal(, )
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :height
  scope :published, where(:published => true)

  has_many :measurements
  has_many :weights
  has_one :withings_account

  def weight
    self.weights.current || self.weights.new(recorded_at: Time.now, value: 0.0, fat_mass_value: 0.0, fat_percentage: 0.0, lean_mass_value: 0.0)
  end

  def fat_mass
    weight.fat_mass_value
  end

  def fat_percentage
    weight.fat_percentage
  end

  def lean_mass
    weight.lean_mass_value
  end

  def bmi
    weight.bmi
  end
end
