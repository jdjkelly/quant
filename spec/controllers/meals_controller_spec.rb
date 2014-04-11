require 'spec_helper'

describe MealsController do

  def valid_attributes
    {
      date: Time.now,
      calories: 0,
      carbohydrates: 0,
      fat: 0,
      protein: 0
    }
  end

  let(:meal)       {Fabricate(:meal)}
  let(:user)       {Fabricate(:user)}
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

      it "should only return the current_user's meals" do
        meal = user.meals.create! valid_attributes
        other_users_meal = other_user.meals.create! valid_attributes

        get :index, {}
        assigns(:meals).should eq([meal])
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

    context "when user is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns the meal to @meal" do
        meal = user.meals.create! valid_attributes
        get :show, {id: meal.to_param}
        assigns(:meal).should eq(meal)
      end

      it "prevents access to another user's meal" do
        other_meal = other_user.meals.create! valid_attributes
        get :show, {id: other_meal.to_param}
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

      it "assigns a new meal as @meal" do
        get :new, {}
        expect(
          assigns(:meal)
        ).to be_a_new(Meal)
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

      it "assigns the requested meal as @meal" do
        meal = user.meals.create! valid_attributes
        get :edit, {id: meal.to_param}
        assigns(:meal).should eq(meal)
      end

      it "prevents access to another user's meal" do
        other_meal = other_user.meals.create! valid_attributes
        get :edit, {id: other_meal.to_param}
        response.should be_redirect
      end
    end
  end

  describe "POST 'create'" do
    context "when a user isn't signed in" do
      it "should redirect" do
        post :create, {meal: valid_attributes}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      describe "with valid params" do
        it "creates a new Meal" do
          expect {
            post :create, {meal: valid_attributes}
          }.to change(Meal, :count).by(1)
        end

        it "assigns a newly created meal as @meal" do
          post :create, {meal: valid_attributes}
          assigns(:meal).should be_a(Meal)
          assigns(:meal).should be_persisted
        end

        it "redirects to the meals index" do
          post :create, {meal: valid_attributes}
          response.should redirect_to(meals_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved meal as @meal" do
          # Trigger the behavior that occurs when invalid params are submitted
          Meal.any_instance.stub(:save).and_return(false)
          post :create, {meal: { calories: 'abc' }}
          assigns(:meal).should be_a_new(Meal)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Meal.any_instance.stub(:save).and_return(false)
          post :create, {meal: { calories: 'abc'  }}
          response.should render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    context "when a user isn't signed in" do
      it "should redirect" do
        put :update, {:id => valid_attributes}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      describe "with valid params" do
        it "updates the requested meal" do
          meal = user.meals.create! valid_attributes
          Meal.any_instance.should_receive(:update_attributes).with({ "calories" => "1.0" })
          put :update, {:id => meal.to_param, :meal => { calories: 1.0}}
        end

        it "assigns the requested meal as @meal" do
          meal = user.meals.create! valid_attributes
          put :update, {:id => meal.to_param, :meal => valid_attributes}
          assigns(:meal).should eq(meal)
        end

        it "redirects to meals index" do
          meal = user.meals.create! valid_attributes
          put :update, {:id => meal.to_param, :meal => valid_attributes}
          response.should redirect_to(meals_path)
        end
      end

      describe "with invalid params" do
        it "assigns the meal as @meal" do
          meal = user.meals.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Meal.any_instance.stub(:save).and_return(false)
          put :update, {:id => meal.to_param, :meal => { calories: 'abc' }}
          assigns(:meal).should eq(meal)
        end

        it "re-renders the 'edit' template" do
          meal = user.meals.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          Meal.any_instance.stub(:save).and_return(false)
          put :update, {:id => meal.to_param, :meal => { calories: 'abc' }}
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when a user isn't signed in" do
      it "should redirect" do
        meal = user.meals.create! valid_attributes
        delete :destroy, {:id => meal.to_param}
        response.should be_redirect
      end
    end

    context "when a user is is signed in" do
      before(:each) do
        sign_in user
      end

      it "destroys the requested meal" do
        meal = user.meals.create! valid_attributes
        expect {
          delete :destroy, {id: meal.to_param}
        }.to change(Meal, :count).by(-1)
      end

      it "redirects to the meals list" do
        meal = user.meals.create! valid_attributes
        delete :destroy, {id: meal.to_param}
        response.should redirect_to(meals_url)
      end
    end
  end

end
