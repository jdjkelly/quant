require 'spec_helper'

describe PlacesController do

  def valid_attributes
    {
      lat: 0.0,
      lng: 0.0,
      date: Time.now
    }
  end

  let(:user) {Fabricate(:user)}
  let(:other_user) {Fabricate(:user)}

  describe "GET 'index'" do
    context "when a user isn't signed in" do
      it "should redirect" do
        get :index
        response.should be_redirect
      end
    end

    context "when a user is signed in" do
      before(:each) do
        sign_in user
      end

      it "should only return the current_user's places" do
        place = user.places.create! valid_attributes
        other_users_place = other_user.places.create! valid_attributes

        get :index, {}
        assigns(:places).should eq([place])
      end
    end
  end

  describe "GET 'show'" do
    context "when a user isn't signed in" do
      it "should redirect" do
        get :show, {id: 1}
        response.should be_redirect
      end
    end

    context "when a user is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns the place to @place" do
        place = user.places.create! valid_attributes
        get :show, {id: place.to_param}
        assigns(:place).should eq(place)
      end

      it "prevents access to another user's place" do
        other_place = other_user.places.create! valid_attributes
        get :show, {id: other_place.to_param}
        response.should be_redirect
      end
    end
  end

  describe "GET 'new'" do
    context "when a user isn't signed in" do
      it "should redirect" do
        get :new, {}
        response.should be_redirect
      end
    end

    context "when a user is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns a new place as @place" do
        get :new, {}
        assigns(:place).should be_a_new(Place)
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

      it "assigns the requested place as @place" do
        place = user.places.create! valid_attributes
        get :edit, {id: place.to_param}
        assigns(:place).should eq(place)
      end

      it "prevents access to another user's place" do
        other_place = other_user.places.create! valid_attributes
        get :edit, {id: other_place.to_param}
        response.should be_redirect
      end
    end
  end

  describe "POST 'create'" do
    context "when a user isn't signed in" do
      it "should redirect" do
        post :create, {place: valid_attributes}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      describe "with valid params" do
        it "creates a new Place" do
          expect {
            post :create, {place: valid_attributes}
          }.to change(Place, :count).by(1)
        end

        it "assigns a newly created place as @place" do
          post :create, {place: valid_attributes}
          assigns(:place).should be_a(Place)
          assigns(:place).should be_persisted
        end

        it "redirects to the created place" do
          post :create, {place: valid_attributes}
          response.should redirect_to(place_path(Place.last))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved place as @place" do
          # Trigger the behavior that occurs when invalid params are submitted
          Place.any_instance.stub(:save).and_return(false)
          post :create, {place: { lat: 'abc' }}
          assigns(:place).should be_a_new(Place)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Place.any_instance.stub(:save).and_return(false)
          post :create, {place: { lat: 'abc' }}
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
        it "updates the requested place" do
          place = user.places.create! valid_attributes
          Place.any_instance.should_receive(:update_attributes).with({ "lat" => "1.0" })
          put :update, {id: place.to_param, place: { lat: 1.0 }}
        end

        it "assigns the requested place as @place" do
          place = user.places.create! valid_attributes
          put :update, {id: place.to_param, place: valid_attributes}
          assigns(:place).should eq(place)
        end

        it "redirects to the place" do
          place = user.places.create! valid_attributes
          put :update, {id: place.to_param, place: valid_attributes}
          response.should redirect_to(place_path(place))
        end
      end

      describe "with invalid params" do
        it "assigns the place as @place" do
          place = user.places.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Place.any_instance.stub(:save).and_return(false)
          put :update, {id: place.to_param, place: { lat: 'abc' }}
          assigns(:place).should eq(place)
        end

        it "re-renders the 'edit' template" do
          place = user.places.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Place.any_instance.stub(:save).and_return(false)
          put :update, {id: place.to_param, place: { lat: 'abc'  }}
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when a user isn't signed in" do
      it "should redirect" do
        place = user.places.create! valid_attributes
        delete :destroy, {id: place.to_param}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      it "destroys the requested place" do
        place = user.places.create! valid_attributes
        expect {
          delete :destroy, {id: place.to_param}
        }.to change(Place, :count).by(-1)
      end

      it "redirects to the places list" do
        place = user.places.create! valid_attributes
        delete :destroy, {id: place.to_param}
        response.should redirect_to(places_url)
      end
    end
  end

end
