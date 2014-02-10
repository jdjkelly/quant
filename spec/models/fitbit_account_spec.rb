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
       to_return(:status => 200, :body => "{\"user\":{\"timezone\":\"America/New_York\"}}", :headers => {})
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
      context "with { sync: true }" do
        it "requests .weights_since self.synced_at" do
          FitbitAccount.any_instance.should_receive(:weights_since).with(fitbit_account.synced_at, {})
          fitbit_account.weights({ sync: true })
        end

      end

      context "with { import: true }" do
        it "requests .weights_since self.actived_at" do
          FitbitAccount.any_instance.should_receive(:weights_since).with(fitbit_account.activated_at, {})
          fitbit_account.weights({ import: true })
        end
      end

      context "without options" do
        it "does not request .weights_since" do
          FitbitAccount.any_instance.should_not_receive(:weights_since)
          fitbit_account.weights
        end

        it "sends weights response to .process_weights" do
          FitbitAccount.any_instance.should_receive(:process_weights).with([{"bmi"=>31.45, "date"=>"2014-01-11", "logId"=>1389484799000, "time"=>"23:59:59", "weight"=>195}, {"bmi"=>30.81, "date"=>"2014-01-18", "logId"=>1390089599000, "time"=>"23:59:59", "weight"=>191}])
          fitbit_account.weights
        end
      end
    end

    describe ".weights_since" do
      it "requests weights from yesterday + 30 days forward" do
        yesterday = Date.current - 1.day
        yesterday_in_30_days = yesterday + 30.days
        fitbit_account.weights_since(yesterday)
        a_request(:any, /.*api.fitbit.com\/1\/user\/-\/body\/log\/weight\/date\/#{yesterday_in_30_days.strftime("%F")}\/30d.*/).should have_been_made
      end
    end

    describe ".process_weights" do
      it "persists new weights" do
        expect {
           fitbit_account.send(:process_weights, [{"bmi"=>31.45, "date"=>"2014-01-11", "logId"=>1389484799000, "time"=>"23:59:59", "weight"=>195}, {"bmi"=>30.81, "date"=>"2014-01-18", "logId"=>1390089599000, "time"=>"23:59:59", "weight"=>191}])
        }.to change(Weight, :count).by(2)
      end

      it "raises ArgumentError if no weights sent" do
        expect {
          fitbit_account.send(:process_weights)
        }.to raise_error(ArgumentError)
      end
    end

    describe ".sleeps" do
      context "with { sync: true }" do
        it "requests .sleeps_since self.synced_at" do
          FitbitAccount.any_instance.should_receive(:sleeps_since).with(fitbit_account.synced_at, {sync: true, end_date: Date.current })
          fitbit_account.sleeps({ sync: true })
        end
      end

      context "with { import: true }" do
        it "requests .sleeps_since self.actived_at" do
          FitbitAccount.any_instance.should_receive(:sleeps_since).with(fitbit_account.activated_at, {import: true, period: "max"})
          fitbit_account.sleeps({ import: true })
        end
      end

      context "without options" do
        it "does not request .sleeps_since" do
          FitbitAccount.any_instance.should_not_receive(:sleeps_since)
          fitbit_account.sleeps
        end

        it "sends weights response to .process_sleeps" do
          FitbitAccount.any_instance.should_receive(:process_sleeps).with([{"awakeningsCount"=>14, "duration"=>26160000, "efficiency"=>93, "isMainSleep"=>true, "logId"=>98934441, "minuteData"=>[{"dateTime"=>"00:52:00", "value"=>"3"}], "minutesAfterWakeup"=>0, "minutesAsleep"=>401, "minutesAwake"=>29, "minutesToFallAsleep"=>6, "startTime"=>"2014-01-22T00:52:00.000", "timeInBed"=>436}])
          fitbit_account.sleeps
        end
      end
    end

    describe ".sleeps_since" do
      it "raises an argument error if neither options[:period] nor options[:end_date] are provided" do
        expect {
          fitbit_account.sleeps_since Date.current
        }.to raise_error(ArgumentError)
      end

      it "requests sleeps by date range from Fitbit api" do
        fitbit_account.sleeps_since Date.current - 1.day, { period: "max" }
        a_request(:any, /.*api.fitbit.com\/1\/user\/-\/sleep\/startTime\/date\/#{(Date.current - 1.day).strftime("%F")}\/.*.json/).should have_been_made
      end
    end

    describe ".process_sleeps" do
      it "persists new sleeps" do
        expect {
           fitbit_account.send(:process_sleeps, [{"awakeningsCount"=>14, "duration"=>26160000, "efficiency"=>93, "isMainSleep"=>true, "logId"=>98934441, "minuteData"=>[{"dateTime"=>"00:52:00", "value"=>"3"}], "minutesAfterWakeup"=>0, "minutesAsleep"=>401, "minutesAwake"=>29, "minutesToFallAsleep"=>6, "startTime"=>"2014-01-22T00:52:00.000", "timeInBed"=>436}])
        }.to change(Sleep, :count).by(1)
      end

      it "raises ArgumentError if no sleeps sent" do
        expect {
          fitbit_account.send(:process_sleeps)
        }.to raise_error(ArgumentError)
      end
    end

    describe ".time_zone" do
      it "returns a time zone for the client" do
        expect(
          fitbit_account.time_zone
        ).to eq("America/New_York")
      end
    end

    describe ".user_info" do
      it "returns a hash" do
        expect(
          fitbit_account.send(:user_info)
        ).to eq({"timezone"=>"America/New_York"})
      end
    end

    describe ".client" do
      it "returns a FitbitGem authenticated user" do
        expect(
          fitbit_account.send(:client).class
        ).to eq(Fitgem::Client)
      end
    end
  end
end
