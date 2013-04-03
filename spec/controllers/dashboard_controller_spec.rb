require 'spec_helper'

describe DashboardController do

  let(:user) {Fabricate(:user)}

  describe "GET 'index'" do

    context "when a user isn't signed in" do
      it "should redirect" do
        get :index
        response.should be_redirect
      end
    end

    context "when a user is signed in" do
      it "should be successful" do
        sign_in user
        get :index
        response.should be_success
      end
    end

  end

end
