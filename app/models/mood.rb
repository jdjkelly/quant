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

class Mood < ActiveRecord::Base
  attr_accessible :date, :rating, :description

  validates_presence_of :date
  validates_numericality_of :rating
  validates_inclusion_of :rating, :in => 1..5

  belongs_to :user
end
