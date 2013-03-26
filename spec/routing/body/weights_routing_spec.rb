require "spec_helper"

describe Body::WeightsController do
  describe "routing" do

    it "routes to #index" do
      get("/body/weights").should route_to("body/weights#index")
    end

    it "routes to #new" do
      get("/body/weights/new").should route_to("body/weights#new")
    end

    it "routes to #show" do
      get("/body/weights/1").should route_to("body/weights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/body/weights/1/edit").should route_to("body/weights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/body/weights").should route_to("body/weights#create")
    end

    it "routes to #update" do
      put("/body/weights/1").should route_to("body/weights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/body/weights/1").should route_to("body/weights#destroy", :id => "1")
    end

  end
end
