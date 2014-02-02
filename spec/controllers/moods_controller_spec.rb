require 'spec_helper'

describe MoodsController do

  let(:valid_attributes) {
    {
      rating: 1,
      date: Time.now,
      description: "Some description"
    }
  }

  let(:mood)       {Fabricate(:mood)}
  let(:user)       {Fabricate(:user)}
  let(:other_user) {Fabricate(:user)}

  describe "GET 'index'" do
    context "when a user isn't signed in" do
      it "redirects" do
        get :index
        response.should be_redirect
      end
    end

    context "when a user is signed in" do
      before(:each) do
        sign_in user
      end

      it "only returns the current_user's moods" do
        mood = user.moods.create! valid_attributes
        other_users_mood = other_user.moods.create! valid_attributes

        get :index, {}
        assigns(:moods).should eq([mood])
      end
    end
  end

  describe "GET 'show'" do
    context "when a user isn't signed in" do
      it "redirects" do
        get :show, {id: 1}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns the mood to @mood" do
        mood = user.moods.create! valid_attributes
        get :show, {id: mood.to_param}
        assigns(:mood).should eq(mood)
      end

      it "prevents access to another user's mood" do
        other_mood = other_user.moods.create! valid_attributes
        get :show, {id: other_mood.to_param}
        response.should be_redirect
      end
    end
  end

  describe "GET 'new'" do
    context "when a user isn't signed in" do
      it "redirects" do
        get :new, {}
        response.should be_redirect
      end
    end

    context "what a user is is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns a new mood as @mood" do
        get :new, {}
        assigns(:mood).should be_a_new(Mood)
      end
    end
  end

  describe "GET 'edit'" do
    context "when a user isn't signed in" do
      it "should redirect" do
        get :edit, {id: 1}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns the requested mood as @mood" do
        mood = user.moods.create! valid_attributes
        get :edit, {id: mood.to_param}
        assigns(:mood).should eq(mood)
      end

      it "prevents access to another user's mood" do
        other_mood = other_user.moods.create! valid_attributes
        get :edit, {id: other_mood.to_param}
        response.should be_redirect
      end
    end
  end

  describe "POST 'create'" do

    context "when a user isn't signed in" do
      it "should redirect" do
        post :create, {mood: valid_attributes}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      describe "with valid params" do
        it "creates a new Mood" do
          expect {
            post :create, {mood: valid_attributes}
          }.to change(Mood, :count).by(1)
        end

        it "assigns a newly created mood as @mood" do
          post :create, {mood: valid_attributes}
          assigns(:mood).should be_a(Mood)
          assigns(:mood).should be_persisted
        end

        it "redirects to the moods index" do
          post :create, {mood: valid_attributes}
          response.should redirect_to(moods_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved mood as @mood" do
          # Trigger the behavior that occurs when invalid params are submitted
          Mood.any_instance.stub(:save).and_return(false)
          post :create, {mood: { rating: 'abc' }}
          assigns(:mood).should be_a_new(Mood)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Mood.any_instance.stub(:save).and_return(false)
          post :create, {mood: { rating: 'abc' }}
          response.should render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    context "when a user isn't signed in" do
      it "should redirect" do
        put :update, {id: valid_attributes}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      describe "with valid params" do
        it "updates the requested mood" do
          mood = user.moods.create! valid_attributes
          Mood.any_instance.should_receive(:update_attributes).with({ "rating" => "1.0" })
          put :update, {id: mood.to_param, mood: { rating: 1.0 }}
        end

        it "assigns the requested mood as @mood" do
          mood = user.moods.create! valid_attributes
          put :update, {id: mood.to_param, mood: valid_attributes}
          assigns(:mood).should eq(mood)
        end

        it "redirects to moods index" do
          mood = user.moods.create! valid_attributes
          put :update, {id: mood.to_param, mood: valid_attributes}
          response.should redirect_to(moods_path)
        end
      end

      describe "with invalid params" do
        it "assigns the mood as @mood" do
          mood = user.moods.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Mood.any_instance.stub(:save).and_return(false)
          put :update, {id: mood.to_param, mood: { rating: 'abc' }}
          assigns(:mood).should eq(mood)
        end

        it "re-renders the 'edit' template" do
          mood = user.moods.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Mood.any_instance.stub(:save).and_return(false)
          put :update, {id: mood.to_param, mood: { rating: 'abc' }}
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when a user isn't signed in" do
      it "should redirect" do
        mood = user.moods.create! valid_attributes
        delete :destroy, {id: mood.to_param}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      it "destroys the requested mood" do
        mood = user.moods.create! valid_attributes
        expect {
          delete :destroy, {id: mood.to_param}
        }.to change(Mood, :count).by(-1)
      end

      it "redirects to the moods list" do
        mood = user.moods.create! valid_attributes
        delete :destroy, {id: mood.to_param}
        response.should redirect_to(moods_url)
      end
    end
  end

end
