require 'spec_helper'

describe "Meals" do
  describe "GET /meals" do
    context "when not signed in" do
      it "redirects" do
        get meals_path
        response.status.should be(302) # have to be signed in
      end
    end
  end
end
