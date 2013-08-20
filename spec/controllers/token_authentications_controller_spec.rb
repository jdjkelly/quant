require 'spec_helper'

describe TokenAuthenticationsController do

  let(:user) {Fabricate(:user)}

  before(:each) do
    sign_in user
  end

  describe "POST create" do
    context "no authentication_token exists" do
      it "assigns an authentication_token" do
        expect {
          post :create, {:user_id => user.id}
        }.to change(User, :authentication_token)
      end
    end

    context "an authentication_token exists" do
      it "assigns a new authentication_token" do
        expect {
          post :create, {:user_id => user.id}
        }.to change(User, :authentication_token)
      end
    end
  end

  describe "DELETE destroy" do
    context "an authentication_token exists" do
      before(:each) do
        user.authentication_token = "123"
        user.save
      end

      it "destroys the authentication_token" do
        delete :destroy, {:id => user.id}
        user.reload #really not sure why this is necessary
        user.authentication_token.should be_nil
      end

      it "redirects to user edit page" do
        delete :destroy, {:id => user.id}
        response.should redirect_to(edit_user_registration_path(user))
      end
    end
  end

end
