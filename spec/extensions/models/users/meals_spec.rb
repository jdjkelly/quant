require 'spec_helper'

describe Users::Meals do
  include Users::Meals

  let(:user)   { Fabricate(:user)}

  before do
    3.times do |i|
      user.meals.create(date: Date.current - i.days, calories: 0, carbohydrates: 0, fat: 0, protein: 0)
    end
  end

  describe "#meals_from" do
    context "search for 1 day ago" do
      it "finds 2 meals" do
        user.meals_from(Date.yesterday).length.should eq(2)
      end
    end

    context "search for today" do
      it "finds 1 meal" do
        user.meals_from(Date.current).length.should eq(1)
      end
    end
  end

  describe "#meals_after" do
    context "search for 1 day ago" do
      it "finds 1 meal" do
        user.meals_after(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 0 meals" do
        user.meals_after(Date.current).length.should eq(0)
      end
    end
  end

  describe "#meals_before" do
    context "search for 1 day ago" do
      it "finds 1 meal" do
        user.meals_before(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 2 meals" do
        user.meals_before(Date.current).length.should eq(2)
      end
    end
  end

  describe "#meals_on" do
    context "search for 1 day ago" do
      it "finds 1 meal" do
        user.meals_on(Date.yesterday).length.should eq(1)
      end
    end

    context "search for today" do
      it "finds 1 meal" do
        user.meals_on(Date.current).length.should eq(1)
      end
    end
  end
end
