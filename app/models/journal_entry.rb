class JournalEntry < ActiveRecord::Base
  belongs_to :user

	attr_accessible :recorded_at, 
    :feelings, 
    :happiness, 
    :strategies
	
  attr_encrypted :feelings, 
    random_iv: true, 
    compress: true,
    type: :string
  
  attr_encrypted :strategies, 
    random_iv: true,
    compress: true,
    type: :string
  
  attr_encrypted :happiness, 
    random_iv: true,
    type: :integer

	validates :happiness, numericality: { 
    only_integer: true, 
    greater_than: 0, 
    less_than_or_equal_to: 
    10 }
end
