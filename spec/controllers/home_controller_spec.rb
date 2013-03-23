require 'spec_helper'

describe HomeController do

  def valid_session
    {}
  end

  describe "GET index" do
    it "loads a valid response" do
      get :index, {}, valid_session
      response.should be_successful
    end
  end
end
