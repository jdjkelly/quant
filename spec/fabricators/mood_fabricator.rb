# == Schema Information
#
# Table name: moods
#
#  id          :integer          not null, primary key
#  date        :datetime
#  user_id     :integer
#  rating      :decimal(, )
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

Fabricator(:mood) do
  date              "2013-03-30 12:37:56 -0400"
  rating            1
  description       "Some mood"
end
