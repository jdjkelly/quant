require "spec_helper"

describe OmniauthCallbacksController do
  describe "routing" do

    # These specs exist to support the following devise config:
    # config.sign_out_via = :delete

    it "routes to #logout with DELETE" do
      expect(delete: "/users/sign_out").to route_to(controller: "devise/sessions", action: "destroy")
    end

  end
end
