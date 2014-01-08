# == Schema Information
#
# Table name: weights
#
#  id          :integer          not null, primary key
#  type        :string(255)
#  user_id     :integer
#  bmi         :float
#  value       :float
#  lean_mass   :float
#  fat_mass    :float
#  fat_percent :float
#  date        :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  meta        :hstore
#  source      :string(255)
#

Fabricator(:weight) do
  value       0.0
  date "2013-03-30 12:37:56 -0400"
end
