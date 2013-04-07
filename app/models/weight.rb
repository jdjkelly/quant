# == Schema Information
#
# Table name: weights
#
#  id              :integer          not null, primary key
#  type            :string(255)
#  user_id         :integer
#  bmi             :float
#  value           :float
#  lean_mass_value :float
#  fat_mass_value  :float
#  fat_percentage  :float
#  recorded_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Weight < ActiveRecord::Base
  attr_accessible :value, :recorded_at, :lean_mass_value, :fat_mass_value, :fat_percentage

  belongs_to :user

  validates :value, :presence => true, :numericality => true
  validates :recorded_at, :presence => true

  before_save :calculate_bmi
  before_save :calculate_all_known_values

  def self.current
    order("recorded_at DESC").first || self.new(recorded_at: Time.now, value: 0.0, fat_mass_value: 0.0, fat_percentage: 0.0, lean_mass_value: 0.0)
  end

  def calculate_bmi
    return unless self.user && self.user.height
    self.bmi = self.value / self.user.height.to_f ** 2
  end

  def calculate_all_known_values
    if self.lean_mass_value.nil? && self.fat_mass_value.present? || self.fat_percentage.present?
      self.lean_mass_value = self.fat_mass_value.present? ? self.value - self.fat_mass_value : self.value - (self.value * (self.fat_percentage / 100))
    end

    if self.fat_mass_value.nil? && self.lean_mass_value.present? || self.fat_percentage.present?
      self.fat_mass_value = self.lean_mass_value.present? ? self.value - self.lean_mass_value : self.value - (self.value * (self.fat_percentage / 100))
    end

    if self.fat_percentage.nil? && self.lean_mass_value.present? || self.fat_mass_value.present?
      self.fat_percentage = self.lean_mass_value.present? ? ((self.value - self.lean_mass_value) / self.value) * 100 : (self.fat_mass_value / self.value) * 100
    end
  end

end
