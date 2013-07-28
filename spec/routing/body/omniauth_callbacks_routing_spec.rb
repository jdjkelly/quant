require "spec_helper"

describe OmniauthCallbacksController do
  describe "routing" do

    it "routes to #withings" do
      get("/users/auth/withings/callback").should route_to(controller: "omniauth_callbacks", action: "withings")
    end

    it "routes to #fitbit" do
      get("/users/auth/fitbit/callback").should route_to(controller: "omniauth_callbacks", action: "fitbit")
    end

  end
end
