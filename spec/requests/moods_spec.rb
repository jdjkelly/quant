require 'spec_helper'

describe "Moods" do

  let(:user) {Fabricate(:user)}

  describe "GET /moods" do
    context "when not signed in" do
      it "redirects" do
        get moods_path
        expect(
          response.status
        ).to eq(302) # have to be signed in
      end
    end

    context "when signed in" do
      before(:each) do
        ApplicationController.any_instance.stub(:current_user).and_return(user)
        MoodsController.any_instance.stub(:authenticate_user!).and_return(true)
      end

      it "returns 200" do
        get moods_path
        expect(
          response.status
        ).to eq(200)
      end
    end
  end

  describe "GET /moods/new" do
    context "when not signed in" do
      it "redirects" do
        get new_mood_path
        expect(
          response.status
        ).to eq(302) # have to be signed in
      end
    end

    context "when signed in" do
      before(:each) do
        ApplicationController.any_instance.stub(:current_user).and_return(user)
        MoodsController.any_instance.stub(:authenticate_user!).and_return(true)
      end

      it "returns 200" do
        get new_mood_path
        expect(
          response.status
        ).to eq(200)
      end
    end
  end
end
