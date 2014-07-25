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

    it "returns a 7 day average from the last recorded Weight" do
      user.current_weight.should eq(user.weights.current(:value))
    end

    it "returns the same value as #current" do
      user.current_weight.should eq(user.weights.current(:value))
    end

    context "when the user has a height" do
      before do
        user.update_attribute(:height, 100)
      end
      it "returns valid bmi" do
        user.bmi.to_f.should eq(1.0)
      end
    end
  end

end
