require "spec_helper"

describe MoodsController do
  describe "routing" do

    it "routes to #index" do
      get("/moods").should route_to("moods#index")
    end

    it "routes to #new" do
      get("/moods/new").should route_to("moods#new")
    end

    it "routes to #show" do
      get("/moods/1").should route_to("moods#show", :id => "1")
    end

    it "routes to #edit" do
      get("/moods/1/edit").should route_to("moods#edit", :id => "1")
    end

    it "routes to #create" do
      post("/moods").should route_to("moods#create")
    end

    it "routes to #update" do
      put("/moods/1").should route_to("moods#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/moods/1").should route_to("moods#destroy", :id => "1")
    end

  end
end
