# == Schema Information
#
# Table name: journal_entries
#
#  id                   :integer          not null, primary key
#  feelings             :text
#  happiness            :integer
#  strategies           :text
#  created_at           :datetime
#  updated_at           :datetime
#  user_id              :integer
#  encrypted_happiness  :string(255)
#  encrypted_strategies :text
#  encrypted_feelings   :text
#

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
    greater_than: 0,
    less_than_or_equal_to: 10
  }

  def happiness=(val)
    super(val.to_i)
  end

  private

  # Why is this a method instead of regularly defined
  # as a numericality validator? 
  #
  # We're using a gem called symmetrical-encryption
  # to enforce encryption on these fields. Basically, they
  # come to us as :happiness and :strategies etc, but 
  # we immediately encrypt those values. So in other to validate,
  # we need to cast to an int and then just run some checks 
  # ourselves
  def encrypted_happiness_is_an_integer 
    unless h = happiness.to_i && h > 0 && h <= 10
      errors[:happiness] = "is not a number"
    end
  end

end
