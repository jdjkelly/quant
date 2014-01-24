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

describe FitbitAccount do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :oauth_token }
  it { should validate_presence_of :oauth_token_secret }

  it_behaves_like "a data provider"

  let(:user) {
    user = Fabricate(:user)
    user.fitbit_account = Fabricate.build(:fitbit_account)
    user
  }

  context "as an authenticated user" do
    describe ".get_user_data" do
      it "updates weights on user" do
        pending
      end
    end

    describe ".weights" do
      context "with synced_at stamp" do
        before do
          #TODO: Move this into a general stub file
          stub_request(:get, /.*api.fitbit.com\/1\/user\/-\/body\/log\/weight\/date\/.*\/30d.json/).
            to_return(:status => 200, :body => "{\"weight\":[{\"bmi\":31.45,\"date\":\"2014-01-11\",\"logId\":1389484799000,\"time\":\"23:59:59\",\"weight\":195},{\"bmi\":30.81,\"date\":\"2014-01-18\",\"logId\":1390089599000,\"time\":\"23:59:59\",\"weight\":191}]}", :headers => {})

          user.fitbit_account.synced_at = Time.now
        end
        it "requests weights since synced_at stamp" do
          pending
        end
      end

      context "with importing = true" do
        it "requests all user weights since user activation date, in 30 day blocks" do
          pending
        end
      end

      context "without options" do
        it "requests weights within last 1 month" do
          pending
        end
      end
    end

    describe ".sleeps" do
      it "requests sleeps from Fitbit API" do
        pending
      end
    end

    describe ".meals" do
      it "requests sleeps from Fitbit API" do
        pending
      end
    end
  end
end
