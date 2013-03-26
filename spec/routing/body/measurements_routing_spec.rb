require "spec_helper"

describe Body::MeasurementsController do
  describe "routing" do

    it "routes to #index" do
      get("/body/measurements").should route_to("body/measurements#index")
    end

    it "routes to #new" do
      get("/body/measurements/new").should route_to("body/measurements#new")
    end

    it "routes to #show" do
      get("/body/measurements/1").should route_to("body/measurements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/body/measurements/1/edit").should route_to("body/measurements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/body/measurements").should route_to("body/measurements#create")
    end

    it "routes to #update" do
      put("/body/measurements/1").should route_to("body/measurements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/body/measurements/1").should route_to("body/measurements#destroy", :id => "1")
    end

  end
end
