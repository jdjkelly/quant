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
#  grpid           :integer
#

class Weight < ActiveRecord::Base
  attr_accessible :value, :recorded_at, :lean_mass_value, :fat_mass_value, :fat_percentage,
                  :grpid, :source, :meta

  # We use this to store provider-specific metadata about the weight. In the case of withings,
  # we get a pkey called grpid that is useful for maintaining a single copy of each record.
  serialize :meta, ActiveRecord::Coders::Hstore

  belongs_to :user

  validates :value, :presence => true, :numericality => true
  validates :recorded_at, :presence => true

  before_save :calculate_all_known_values

  def self.current
    order("recorded_at DESC").first
  end

  def calculate_all_known_values
    %w(lean_mass_value fat_mass_value fat_percentage_value bmi).each do |measurement|
      self.try("calculate_#{measurement}")
    end
  end

   def calculate_bmi
    return unless self.user && self.user.height
    self.bmi = Unit.new(self.value, :pounds).to(:kilograms) / ( Unit.new(self.user.height, :centimeters).to(:meters) ** 2 )
  end

  def calculate_lean_mass_value
    return unless self.lean_mass_value.nil? && self.fat_mass_value.present? || self.fat_percentage.present?
    self.lean_mass_value = self.fat_mass_value.present? ? self.value - self.fat_mass_value : self.value - (self.value * (self.fat_percentage / 100))
  end

  def calculate_fat_mass_value
    return unless self.fat_mass_value.nil? && self.lean_mass_value.present? || self.fat_percentage.present?
    self.fat_mass_value = self.lean_mass_value.present? ? self.value - self.lean_mass_value : self.value - (self.value * (self.fat_percentage / 100))
  end

  def calculate_fat_percentage_value
    return unless self.fat_percentage.nil? && self.lean_mass_value.present? || self.fat_mass_value.present?
    self.fat_percentage = self.lean_mass_value.present? ? ((self.value - self.lean_mass_value) / self.value) * 100 : (self.fat_mass_value / self.value) * 100
  end

  def self.update_bmi_for_user id
    User.find(id).weights.each do |weight|
      weight.save #executes callbacks that update the bmi
    end
  end

end
