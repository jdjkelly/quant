# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  recorded_at :datetime
#  lat         :decimal(, )
#  lng         :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Location < ActiveRecord::Base
  acts_as_geolocated

  belongs_to :user

  validates :recorded_at, :presence => true
  validates :lat, :presence => true, :numericality => true
  validates :lng, :presence => true, :numericality => true

  attr_accessible :recorded_at, :lat, :lng
end
