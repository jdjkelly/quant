# == Schema Information
#
# Table name: meals
#
#  id            :integer          not null, primary key
#  date          :date
#  calories      :integer
#  carbohydrates :integer
#  protein       :integer
#  fat           :integer
#  user_id       :integer
#  description   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

Fabricator(:meal) do
  date              "2013-03-30 12:37:56 -0400"
  calories          100
  carbohydrates     20
  fat               30
  protein           10
end
