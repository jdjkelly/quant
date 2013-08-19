require "spec_helper"

describe MealsController do
  describe "routing" do

    it "routes to #index" do
      get("/meals").should route_to("meals#index")
    end

    it "routes to #new" do
      get("/meals/new").should route_to("meals#new")
    end

    it "routes to #show" do
      get("/meals/1").should route_to("meals#show", :id => "1")
    end

    it "routes to #edit" do
      get("/meals/1/edit").should route_to("meals#edit", :id => "1")
    end

    it "routes to #create" do
      post("/meals").should route_to("meals#create")
    end

    it "routes to #update" do
      put("/meals/1").should route_to("meals#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/meals/1").should route_to("meals#destroy", :id => "1")
    end

  end
end
