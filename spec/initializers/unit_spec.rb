require 'spec_helper'

describe Unit do

  describe "to(:unit)" do

    context "when converting 1 meter to feet" do
      it "is 3.28084" do
        Unit.new(1, :meters).to(:feet).should eq(3.28084)
      end
    end

  end

end
