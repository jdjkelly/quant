require 'spec_helper'

describe OmniauthCallbacksController do

  let(:user) {Fabricate(:user)}

  describe "GET 'withings'" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:withings]

      stub_request(:get, /.*wbsapi.withings.net\/user\?action=getbyuserid.*/).
        to_return(:status => 200, :body => "{\"status\":0,\"body\":{\"users\":[{\"id\":0,\"firstname\":\"Test\",\"lastname\":\"User\",\"shortname\":\"TES\",\"gender\":0,\"fatmethod\":131,\"birthdate\":598467600,\"ispublic\":5}]}}", :headers => {})

      stub_request(:get, /.*wbsapi.withings.net\/measure\?action=getmeas.*/).
        to_return(:status => 200, :body => "{\"status\":0,\"body\":{\"updatetime\":1370730432,\"more\":370,\"measuregrps\":[{\"grpid\":123986552,\"attrib\":0,\"date\":1370691572,\"category\":1,\"measures\":[{\"value\":64400,\"type\":1,\"unit\":-3},{\"value\":54519,\"type\":5,\"unit\":-3},{\"value\":15344,\"type\":6,\"unit\":-3},{\"value\":9881,\"type\":8,\"unit\":-3}]}]}}", :headers => {})
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

end
