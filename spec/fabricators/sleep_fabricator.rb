# == Schema Information
#
# Table name: sleeps
#
#  id         :integer          not null, primary key
#  start      :datetime
#  end        :datetime
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  meta       :hstore
#  source     :string(255)
#

Fabricator(:sleep) do |f|
  start "2013-03-10 12:37:56 -0400"
  f.end "2013-03-11 12:37:56 -0400"
end
