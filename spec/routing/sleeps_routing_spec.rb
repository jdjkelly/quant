require "spec_helper"

describe SleepsController do
  describe "routing" do

    it "routes to #index" do
      get("/sleeps").should route_to("sleeps#index")
    end

    it "routes to #new" do
      get("/sleeps/new").should route_to("sleeps#new")
    end

    it "routes to #show" do
      get("/sleeps/1").should route_to("sleeps#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sleeps/1/edit").should route_to("sleeps#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sleeps").should route_to("sleeps#create")
    end

    it "routes to #update" do
      put("/sleeps/1").should route_to("sleeps#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sleeps/1").should route_to("sleeps#destroy", :id => "1")
    end

  end
end
