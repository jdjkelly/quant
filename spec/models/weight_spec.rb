# == Schema Information
#
# Table name: weights
#
#  id              :integer          not null, primary key
#  type            :string(255)
#  user_id         :integer
#  bmi             :float
#  value           :float
#  lean_mass_value :float
#  fat_mass_value  :float
#  fat_percentage  :float
#  recorded_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  grpid           :integer
#

require 'spec_helper'

describe Weight do
  it { should validate_presence_of :value }
  it { should validate_numericality_of :value }
  it { should belong_to(:user) }
  it { should validate_presence_of :recorded_at }

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
        weight_with_height.calculate_bmi.should eq(11.662604224058766)
      end
    end
  end

  describe "#calculate_all_known_values" do
    context "when user doesn't have lean_mass_value, fat_mass_value, or fat_percentage" do
      it "isn't changed" do
        weight.calculate_all_known_values
        weight.changed?.should be_false
      end
    end
    context "when user has a lean_mass_value" do
      it "updates fat_mass_value and fat_percentage" do
        weight.update_attributes(lean_mass_value: 9.0, value: 10.0)
        weight.fat_mass_value.should(eq(1.0)) && weight.fat_percentage.should(eq(10.0))
      end
    end
    context "when user has a fat_mass_value" do
      it "updates lean_mass_value and fat_percentage" do
        weight.update_attributes(fat_mass_value: 9.0, value: 10.0)
       weight.lean_mass_value.should(eq(1.0)) && weight.fat_percentage.should(eq(90.0))
      end
    end
    context "when user has a fat_percentage" do
      it "updates lean_mass_value and fat_percentage" do
        weight.update_attributes(fat_percentage: 50.0, value: 10.0)
        weight.lean_mass_value.should(eq(5.0)) && weight.fat_mass_value.should(eq(5.0))
      end
    end
  end

end
