require 'spec_helper'

describe OmniauthCallbacksController do

  let(:user) {Fabricate(:user)}

  describe "GET 'withings'" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:withings]
      WithingsAccount.any_instance.stub(:import).and_return(true)
    end

    context "when a user is signed in" do
       it "should create a WithingsAccount relation" do
        sign_in user
        get :withings
        user.withings_account.should be_present
      end
    end

    context "when a user already has a WithingsAccount" do
      it "should set a flash notification" do
        User.any_instance.stub(:has_withings_auth?) { true }
        sign_in user
        get :withings
        flash[:success].should == "You've already synchronized your scale"
      end
    end

    context "when there is no current user" do
       it "should redirect to login" do
        get :withings
        response.should be_redirect
      end
    end
  end

  describe "GET 'fitbit'" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:fitbit]
      FitbitAccount.any_instance.stub(:import).and_return(true)
    end

    context "when a user is signed in" do
       it "should create a FitbitAccount relation" do
        sign_in user
        get :fitbit
        user.fitbit_account.should be_present
      end
    end

    context "when a user already has a FitbitAccount" do
      it "should set a flash notification" do
        User.any_instance.stub(:has_fitbit_auth?) { true }
        sign_in user
        get :fitbit
        flash[:success].should == "You've already synchronized your Fitbit account"
      end
    end

    context "when there is no current user" do
       it "should redirect to login" do
        get :fitbit
        response.should be_redirect
      end
    end
  end

  describe "GET 'foursquare'" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:foursquare]
      FoursquareAccount.any_instance.stub(:import).and_return(true)
    end
    context "when a user is signed in" do
      it "show create a FoursquareAccount relation" do
        sign_in user
        get :foursquare
        user.foursquare_account.should be_present
      end
    end

    context "when a user already has a FoursquareAccount" do
      it "should set a flash notification" do
        User.any_instance.stub(:has_foursquare_auth?) { true }
        sign_in user
        get :foursquare
        flash[:success].should == "You've already synchronized your Foursquare account"
      end
    end

    context "when there is no current user" do
      it "should redirect to login" do
        get :foursquare
        response.should be_redirect
      end
    end
  end
end
