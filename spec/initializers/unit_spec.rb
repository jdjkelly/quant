require 'spec_helper'

describe Unit do

  describe ".to_unit" do

    context "when converting 1 meter to feet" do
      it "is 3.28084" do
        Unit.new(1, :meters).to_unit(:feet).should eq(3.28084)
      end
    end

    context "when converting 1 pound to one pound (same unit)" do
      it "is 3.28084" do
        Unit.new(1, :pounds).to_unit(:pounds).should eq(1)
      end
    end
  end

  describe ".to_system" do
    context "when converting 1 meter to imperial" do
      it "is 3.28084" do
        Unit.new(1, :meters).to_system(:imperial).should eq(3.28084)
      end
    end

    context "when converting 1 foot to metric" do
      it "is 3.28084" do
        Unit.new(1, :feet).to_system(:metric).should eq(0.3048)
      end
    end
  end

end
