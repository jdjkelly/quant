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
#  height                 :float
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable, :omniauth_providers => [:withings, :fitbit]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :height

  scope :published, where(:published => true)

  validates_numericality_of :height, :allow_nil => true
  validates_presence_of :name

  after_save :update_weights_bmi, :if => :height_changed?

  has_many :measurements
  has_many :weights

  has_one :withings_account
  has_one :fitbit_account

  def current_weight
    self.weights.current
  end

  def weight
    return unless current_weight
    current_weight.value
  end

  def fat_mass
    return unless current_weight
    current_weight.fat_mass_value
  end

  def fat_percentage
    return unless current_weight
    current_weight.fat_percentage
  end

  def lean_mass
    return unless current_weight
    current_weight.lean_mass_value
  end

  def bmi
    return unless current_weight
    current_weight.bmi
  end

  def has_withings_auth?
    withings_account
  end

  def has_fitbit_auth?
    fitbit_account
  end

  def has_scale_auth?
    has_withings_auth?
  end

  protected

  def update_weights_bmi
    Weight.update_bmi_for_user(id)
  end
end
