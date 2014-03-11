# == Schema Information
#
# Table name: meals
#
#  id            :integer          not null, primary key
#  date          :date
#  calories      :integer
#  carbohydrates :integer
#  protein       :integer
#  fat           :integer
#  user_id       :integer
#  description   :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Meal < ActiveRecord::Base
  attr_accessible :date, :calories, :carbohydrates, :fat, :protein, :description

  validates_presence_of :date, :calories
  validates_numericality_of :calories
  validates_numericality_of :carbohydrates, :fat, :protein

  belongs_to :user

  MACRO_NUTRIENTS = %w(carbohydrates fat protein)

  def self.most_recent(count)
    order("date DESC").limit(count)
  end

  def self.macro_nutrients
    MACRO_NUTRIENTS
  end

  def unit
    "grams"
  end

  def carbohydrates_percentage
    return 0 if carbohydrates.nil?
    percentage(:carbohydrates).round(1)
  end

  def fat_percentage
    return 0 if fat.nil?
    percentage(:fat).round(1)
  end

  def protein_percentage
    return 0 if protein.nil?
    percentage(:protein).round(1)
  end


  private

  def percentage nutrient
    return 0 if self.send(nutrient.to_sym) == 0

    sum = 0
    Meal.macro_nutrients.each do |macro_nutrient|
      sum += self.send(macro_nutrient.to_sym)
    end
    self.send(nutrient).to_f / sum * 100
  end

end
