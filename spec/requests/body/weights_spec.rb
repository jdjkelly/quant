require 'spec_helper'

describe "Weights" do
  describe "GET /body/weights" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get body_weights_path
      response.status.should be(200)
    end
  end
end
