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
  it { should be_a_data_provider_for :weights, :sleeps }

  it_behaves_like "a data provider"

  let(:user) {
    user = Fabricate(:user)
    user.fitbit_account = Fabricate.build(:fitbit_account)
    user
  }

  let(:fitbit_account) {
    user.fitbit_account
  }

  before do
    stub_request(:get, /.*api.fitbit.com\/1\/user\/-\/sleep\/startTime\/date\/.*\/.*.json/).
      to_return(status: 200, body: "{\"sleep-startTime\": [{\"dateTime\": \"2014-01-22\",\"value\": \"00:52\"}]}", headers: {})

    stub_request(:get, /.*api.fitbit.com\/1\/user\/-\/body\/log\/weight\/date\/.*\/30d.json/).
      to_return(status: 200, body: "{\"weight\":[{\"bmi\":31.45,\"date\":\"2014-01-11\",\"logId\":1389484799000,\"time\":\"23:59:59\",\"weight\":195},{\"bmi\":30.81,\"date\":\"2014-01-18\",\"logId\":1390089599000,\"time\":\"23:59:59\",\"weight\":191}]}", :headers => {})

    stub_request(:get, /.*api.fitbit.com\/1\/user\/-\/sleep\/date\/.*.json/).
      to_return(status: 200, body: "{\"sleep\":[{\"awakeningsCount\":14,\"duration\":26160000,\"efficiency\":93,\"isMainSleep\":true,\"logId\":98934441,\"minuteData\":[{\"dateTime\":\"00:52:00\",\"value\":\"3\"}],\"minutesAfterWakeup\":0,\"minutesAsleep\":401,\"minutesAwake\":29,\"minutesToFallAsleep\":6,\"startTime\":\"2014-01-22T00:52:00.000\",\"timeInBed\":436}],\"summary\":{\"totalMinutesAsleep\":401,\"totalSleepRecords\":1,\"totalTimeInBed\":436}}")

    stub_request(:get, /.*api.fitbit.com\/1\/user\/-\/profile.json/).
       to_return(:status => 200, :body => "", :headers => {})
  end

  context "with a user" do
    before do
      # Let user #after_create occur - I'm not sure why this is all necessary though?
      user.save
      user.weights.delete_all
      user.sleeps.delete_all
      user.fitbit_account.synced_at = Date.current - 1.day
    end

    describe ".sync" do
      it "updates weights on user" do
        expect{fitbit_account.sync}.to change{user.weights.count}.by(2)
      end

      it "updates sleeps on user" do
        expect{fitbit_account.sync}.to change{user.sleeps.count}.by(1)
      end
    end

    describe ".weights" do
      context "with synced_at stamp" do
        before do
          fitbit_account.synced_at = Time.now
        end
        it "requests weights since synced_at stamp" do

          # FitbitAccount.should_receive(:weights_since).with("02134")

          # fitbit_account.weights({ sync: true })

          pending
        end
      end

      context "with { import: true }" do
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

    describe ".weights_since" do
      it "requests no weights if no options provided" do
        fitbit_account.weights_since()
        a_request(:any, /.*api.fitbit.com\/1\/user\/-\/body\/log\/weight\/date.*/).should_not have_been_made
      end

      it "requests weights from yesterday + 30 days forward" do
        yesterday = Date.current - 1.day
        yesterday_in_30_days = yesterday + 30.days
        fitbit_account.weights_since(yesterday)
        a_request(:any, /.*api.fitbit.com\/1\/user\/-\/body\/log\/weight\/date\/#{yesterday_in_30_days.strftime("%F")}\/30d.*/).should have_been_made
      end
    end

    describe ".process_weights" do
      pending
    end

    describe ".sleeps" do
      it "requests sleeps from Fitbit API" do
        pending
      end
    end


    describe ".sleeps_since" do
      pending
    end

    describe ".process_sleeps" do
      pending
    end

    describe ".time_zone" do
      pending
    end

    describe ".user_info" do
      pending
    end
  end
end
