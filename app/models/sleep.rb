class Sleep < ActiveRecord::Base
  attr_accessible :start, :end

  validates_presence_of :start, :end
  validate :end_after_start

  belongs_to :user

  def end_after_start
    if self.end.present? && start.present? && self.end < start
      errors.add(:end, "can't happen before start time")
    end
  end
end
