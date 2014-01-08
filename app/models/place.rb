# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  date       :datetime
#  lat        :decimal(, )
#  lng        :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#

class Place < ActiveRecord::Base
  acts_as_geolocated

  belongs_to :user

  validates :date, presence: true
  validates :lat, presence: true, numericality: true
  validates :lng, presence: true, numericality: true

  attr_accessible :date, :lat, :lng
end
