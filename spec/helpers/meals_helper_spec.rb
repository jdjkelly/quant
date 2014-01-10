require 'spec_helper'

describe MealsHelper do
  # helper MealsHelper

  let(:meals) {
    3.times do
      Fabricate(:meal)
    end
    Meal.all
  }

  describe '.macro_percent_for_meals' do
    it 'returns correct carb percentage for an array of meals' do
      expect(helper.macro_percent_for_meals(meals, :carbohydrates)).to eq(33.33333333333333)
    end

    it 'returns correct protein percentage for an array of meals' do
      expect(helper.macro_percent_for_meals(meals, :protein)).to eq(16.666666666666664)
    end

    it 'returns correct fat percentage for an array of meals' do
      expect(helper.macro_percent_for_meals(meals, :fat)).to eq(50.0)
    end
  end
end
