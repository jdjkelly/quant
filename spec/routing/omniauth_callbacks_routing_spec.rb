require "spec_helper"

describe OmniauthCallbacksController do
  describe "routing" do

    # These specs exist to support the following devise config:
    # config.sign_out_via = :get

    it "routes to #logout with GET" do
      get("/users/sign_out").should route_to(controller: "devise/sessions", action: "destroy")
    end

    it "does not route to #logout with DELETE" do
      expect(delete: "/users/sign_out").not_to be_routable
    end

  end
end
