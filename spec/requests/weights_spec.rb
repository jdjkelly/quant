require 'spec_helper'

describe "Weights" do

  let(:user) {Fabricate(:user)}

  describe "GET /weights" do
    context "when not signed in" do
      it "redirects" do
        get weights_path
        expect(
          response.status
        ).to eq(302) # have to be signed in
      end
    end

    context "when signed in" do
      before(:each) do
        ApplicationController.any_instance.stub(:current_user).and_return(user)
        WeightsController.any_instance.stub(:authenticate_user!).and_return(true)
      end

      it "returns 200" do
        get weights_path
        expect(
          response.status
        ).to eq(200)
      end
    end
  end

  describe "GET /weights/new" do
    context "when not signed in" do
      it "redirects" do
        get new_weight_path
        expect(
          response.status
        ).to eq(302) # have to be signed in
      end
    end

    context "when signed in" do
      before(:each) do
        ApplicationController.any_instance.stub(:current_user).and_return(user)
        WeightsController.any_instance.stub(:authenticate_user!).and_return(true)
      end

      it "returns 200" do
        get new_weight_path
        expect(
          response.status
        ).to eq(200)
      end
    end
  end
end
