# == Schema Information
#
# Table name: weights
#
#  id          :integer          not null, primary key
#  type        :string(255)
#  user_id     :integer
#  bmi         :float
#  value       :float
#  lean_mass   :float
#  fat_mass    :float
#  fat_percent :float
#  date        :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  meta        :hstore
#  source      :string(255)
#

require 'spec_helper'

describe Weight do
  it { should validate_presence_of :value }
  it { should validate_numericality_of :value }
  it { should validate_numericality_of :lean_mass }
  it { should validate_numericality_of :fat_mass }
  it { should validate_numericality_of :fat_percent }
  it { should belong_to(:user) }
  it { should validate_presence_of :date }

  let(:weight) {Fabricate(:weight)}
  let(:user)   { Fabricate(:user) { height 165 } }
  let(:weight_with_height) {
    user.weights.new(value: 70)
  }

  describe "#calculate_bmi" do
    context "when user doesn't have height" do
      it "returns nil" do
        weight.calculate_bmi.should be_nil
      end
    end
    context "when user has a height" do
      it "returns a value" do
        weight_with_height.calculate_bmi.should eq(25.711662075298435)
      end
    end
  end

  describe "#calculate_all_known_values" do
    context "when user doesn't have lean_mass, fat_mass, or fat_percent" do
      it "isn't changed" do
        weight.calculate_all_known_values
        weight.changed?.should be_false
      end
    end
    context "when user has a lean_mass" do
      it "updates fat_mass and fat_percent" do
        weight.update_attributes(lean_mass: 9.0, value: 10.0)
        weight.fat_mass.should(eq(1.0)) && weight.fat_percent.should(eq(10.0))
      end
    end
    context "when user has a fat_mass" do
      it "updates lean_mass and fat_percent" do
        weight.update_attributes(fat_mass: 9.0, value: 10.0)
        weight.lean_mass.should(eq(1.0)) && weight.fat_percent.should(eq(90.0))
      end
    end
    context "when user has a fat_percent" do
      it "updates lean_mass and fat_percent" do
        weight.update_attributes(fat_percent: 50.0, value: 10.0)
        weight.lean_mass.should(eq(5.0)) && weight.fat_mass.should(eq(5.0))
      end
    end
  end

  describe ".interpolate" do
    pending
  end

end
