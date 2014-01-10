require 'spec_helper'

describe "Sleeps" do
  describe "GET /sleeps" do
    context "when not signed in" do
      it "redirects" do
        get weights_path
        response.status.should be(302) # have to be signed in
      end
    end
  end
end
