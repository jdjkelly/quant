class JournalEntry < ActiveRecord::Base
	belongs_to :user
	attr_accessible :recorded_at, :feelings, :happiness, :strategies
	
	validates :happiness, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }
	
end
