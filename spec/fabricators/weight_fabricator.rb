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

Fabricator(:weight) do
  value       0.0
  recorded_at "2013-03-30 12:37:56 -0400"
end
