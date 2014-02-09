# == Schema Information
#
# Table name: fitbit_accounts
#
#  id                 :integer          not null, primary key
#  uid                :string(255)
#  oauth_token        :string(255)
#  oauth_token_secret :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  synced_at          :datetime
#  activated_at       :datetime
#

require 'spec_helper'
require 'shared_examples_a_data_provider'

describe FoursquareAccount do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :oauth_token }
  it { should be_a_data_provider_for :places }

  it_behaves_like "a data provider"

  let(:user) {
    user = Fabricate(:user)
    user.foursquare_account = Fabricate.build(:foursquare_account)
    user
  }

  let(:foursquare_account) {
    user.foursquare_account
  }

  context "with a user" do
    describe ".places" do
      pending
    end

    describe ".places_since" do
      it "requests sleeps from Fitbit API" do
        pending
      end
    end

    describe ".client" do
      pending
    end

    describe "#authenticted_user" do
      pending
    end

    describe ".process_places" do
      pending
    end

    describe ".parse_created_at_with_time_zone_offset" do
      pending
    end
  end
end
