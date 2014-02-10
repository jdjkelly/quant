require 'spec_helper'

describe "Places" do
  describe "GET /places" do
    context "when not signed in" do
      it "redirects" do
        get places_path
        response.status.should be(302) # have to be signed in
      end
    end
  end
end
