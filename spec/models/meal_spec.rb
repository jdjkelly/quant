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

require 'spec_helper'

describe Meal do
  it { should validate_presence_of :date }
  it { should validate_presence_of :calories }
  it { should validate_numericality_of :calories }
  it { should validate_numericality_of :carbohydrates }
  it { should validate_numericality_of :fat }
  it { should validate_numericality_of :protein }
  it { should belong_to(:user) }

  let(:meal) { Fabricate.build(:meal) }

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

    context "all macros are set to 0" do
      before(:each) do
        meal.carbohydrates = 0
        meal.protein = 0
        meal.fat = 0
      end

      it "returns 0 for each macro percentage" do
        meal.carbohydrates_percentage.should(eq(0.0))
        meal.fat_percentage.should(eq(0.0))
        meal.protein_percentage.should(eq(0.0))
      end
    end
  end
end
