require "spec_helper"

describe WeightsController do
  describe "routing" do

    it "routes to #index" do
      get("/weights").should route_to("weights#index")
    end

    it "routes to #new" do
      get("/weights/new").should route_to("weights#new")
    end

    it "routes to #show" do
      get("/weights/1").should route_to("weights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weights/1/edit").should route_to("weights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weights").should route_to("weights#create")
    end

    it "routes to #update" do
      put("/weights/1").should route_to("weights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weights/1").should route_to("weights#destroy", :id => "1")
    end

  end
end
