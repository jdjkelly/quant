require 'spec_helper'

describe JournalEntriesController do
  let(:user) { Fabricate(:user) }
  let(:valid_attributes) { 
    { 
      "happiness" => "1",
      "strategies" => "test string",
      "feelings" => "test string"
    } 
  }
  
  describe "GET index" do 
    context "when a user isn't signed in" do
      it "redirects" do
        get :index
        response.should be_redirect
      end
    end

    context "when a user is signed in" do
      before(:each) do
        sign_in user
      end

      it "assigns all journal entries as @journal_entries" do
        journal_entry = user.journal_entries.create! valid_attributes
        get :index
        assigns(:journal_entries).should eq([journal_entry])
      end
    end
  end

end
