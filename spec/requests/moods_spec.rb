require 'spec_helper'

describe "Moods" do
  describe "GET /moods" do
    context "when not signed in" do
      it "redirects" do
        get moods_path
        response.status.should be(302) # have to be signed in
      end
    end
  end
end
