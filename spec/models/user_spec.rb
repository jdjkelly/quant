# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#

require 'spec_helper'

describe User do
  it { should have_many(:measurements) }
  it { should have_many(:fat_masses) }
  it { should have_many(:lean_masses) }
  it { should have_many(:fat_percentages) }
  it { should have_many(:weights) }

  describe ".weight" do
    let(:user) {
      Fabricate(:user) do
        weights(count: 3) { |attrs, i| Fabricate(:weight, recorded_at: Time.now + i, value: i.to_f) }
      end
    }
    it "returns the last recorded Weight" do
      user.weight.should eq(user.weights.order("recorded_at DESC").first)
    end

    it "returns the same value as .current" do
      user.weight.should eq(user.weights.current)
    end
  end

  describe ".fat_mass" do
    let(:user) {
      Fabricate(:user) do
        fat_masses(count: 3) { |attrs, i| Fabricate(:fat_mass, recorded_at: Time.now + i, value: i.to_f) }
      end
    }
    it "returns the last recorded FatMass" do
      user.fat_mass.should eq(user.fat_masses.order("recorded_at DESC").first)
    end

    it "returns the same value as .current" do
      user.fat_mass.should eq(user.fat_masses.current)
    end
  end

  describe ".lean_mass" do
    let(:user) {
      Fabricate(:user) do
        lean_masses(count: 3) { |attrs, i| Fabricate(:lean_mass, recorded_at: Time.now + i, value: i.to_f) }
      end
    }
    it "returns the last recorded LeanMass" do
      user.lean_mass.should eq(user.lean_masses.order("recorded_at DESC").first)
    end

    it "returns the same value as .current" do
      user.lean_mass.should eq(user.lean_masses.current)
    end
  end

  describe ".fat_percentage" do
    let(:user) {
      Fabricate(:user) do
        fat_percentages(count: 3) { |attrs, i| Fabricate(:fat_percentage, recorded_at: Time.now + i, value: i.to_f) }
      end
    }
    it "returns the last recorded FatPercentage" do
      user.fat_percentage.should eq(user.fat_percentages.order("recorded_at DESC").first)
    end

    it "returns the same value as .current" do
      user.fat_percentage.should eq(user.fat_percentages.current)
    end
  end
end
