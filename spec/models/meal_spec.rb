require 'spec_helper'

describe Meal do
  it { should validate_presence_of :date }
  it { should validate_presence_of :calories }
  it { should validate_numericality_of :calories }
  it { should validate_numericality_of :carbohydrates }
  it { should validate_numericality_of :fat }
  it { should validate_numericality_of :protein }
  it { should belong_to(:user) }

  let(:meal) { Fabricate(:meal) }

  describe "#percentage" do
    it "calculates carbohydrate percentage correctly" do
      meal.carbohydrates_percentage.should(eq(33.3))
    end

    it "calculates protein percentage correctly" do
      meal.protein_percentage.should(eq(16.7))
    end

    it "calculates fat percentage correctly" do
      meal.fat_percentage.should(eq(50.0))
    end

  end
end
