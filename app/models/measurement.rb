# == Schema Information
#
# Table name: measurements
#
#  id          :integer          not null, primary key
#  value       :float
#  type        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  recorded_at :datetime
#

class Measurement < ActiveRecord::Base
  attr_accessible :value, :recorded_at

  belongs_to :user

  validates :value, :presence => true, :numericality => true
  validates :recorded_at, :presence => true

  def self.current
    order("recorded_at DESC").first
  end
end
