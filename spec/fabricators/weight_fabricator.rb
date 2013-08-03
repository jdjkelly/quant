# == Schema Information
#
# Table name: weights
#
#  id             :integer          not null, primary key
#  type           :string(255)
#  user_id        :integer
#  bmi            :float
#  value          :float
#  lean_mass      :float
#  fat_mass :float
#  fat_percent :float
#  recorded_at    :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  meta           :hstore
#  source         :string(255)
#

Fabricator(:weight) do
  value       0.0
  recorded_at "2013-03-30 12:37:56 -0400"
end
