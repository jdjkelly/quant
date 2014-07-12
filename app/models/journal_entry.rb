class JournalEntry < ActiveRecord::Base
  belongs_to :user

	attr_accessible :recorded_at, 
    :feelings, 
    :happiness, 
    :strategiesi
	
  attr_encrypted :feelings, 
    random_iv: true, 
    compress: true
  
  attr_encrypted :strategies, 
    random_iv: true,
    compress: true

  attr_encrypted :happiness, 
    random_iv: true,
    type: integer

	validates :happiness, numericality: { 
    only_integer: true, 
    greater_than: 0, 
    less_than_or_equal_to: 
    10 }

  validates :encrypted_feelings, 
    symmetric_encryption: true

  validates :encrypted_strategies,
    symmetric_encrpytion: true

  validates :encrypted_happiness,
    symmetric_encrpytion: true

end
