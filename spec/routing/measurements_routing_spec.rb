require "spec_helper"

describe MeasurementsController do
  describe "routing" do

    it "routes to #index" do
      get("/measurements").should route_to("measurements#index")
    end

    it "routes to #new" do
      get("/measurements/new").should route_to("measurements#new")
    end

    it "routes to #show" do
      get("/measurements/1").should route_to("measurements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/measurements/1/edit").should route_to("measurements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/measurements").should route_to("measurements#create")
    end

    it "routes to #update" do
      put("/measurements/1").should route_to("measurements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/measurements/1").should route_to("measurements#destroy", :id => "1")
    end

  end
end
