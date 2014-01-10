class Sleep < ActiveRecord::Base
  attr_accessible :start, :end

  validates_presence_of :start, :end

  belongs_to :user
end
