require 'spec_helper'

describe Users::Weights do
  include Users::Weights

  let(:user) { Fabricate.build(:user) }

  describe "#weight" do
    before(:each) do
      user.save
      2.times do
        user.weights.create(date: Time.now, value: 1.0)
      end
    end

    it "returns the last recorded Weight" do
      user.current_weight.should eq(user.weights.order("date DESC").first)
    end

    it "returns the same value as #current" do
      user.current_weight.should eq(user.weights.current)
    end

    context "when the user has a height" do
      it "returns valid bmi" do
        user.bmi.should eq(100.0)
      end
    end
  end

end
