# == Schema Information
#
# Table name: foursquare_accounts
#
#  id           :integer          not null, primary key
#  uid          :string(255)
#  oauth_token  :string(255)
#  activated_at :datetime
#  synced_at    :datetime
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'
require 'shared_examples_a_data_provider'

describe FoursquareAccount do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :oauth_token }
  it { should be_a_data_provider_for :places }

  it_behaves_like "a data provider"

  let(:user) { Fabricate(:user) }

  let(:foursquare_account) { Fabricate(:foursquare_account, user: user) }

  before do
    stub_request(:get, /.*api.foursquare.com\/v2\/users\/self\/checkins.*/).
      to_return(:status => 200, :body => "{\"meta\":{\"code\":200},\"notifications\":[{\"type\":\"notificationTray\",\"item\":{\"unreadCount\":0}}],\"response\":{\"checkins\":{\"count\":60,\"items\":[{\"id\":\"52f7e2e3498e92497b856745\",\"createdAt\":1391977187,\"type\":\"checkin\",\"timeZoneOffset\":-300,\"venue\":{\"id\":\"4ad88e03f964a520451221e3\",\"name\":\"Future Bakery & Café\",\"contact\":{\"phone\":\"4163667259\",\"formattedPhone\":\"(416) 366-7259\"},\"location\":{\"address\":\"483 Bloor St W\",\"crossStreet\":\"at Brunswick Ave.\",\"lat\":43.665884,\"lng\":-79.407433,\"postalCode\":\"M5S 1Y2\",\"cc\":\"CA\",\"city\":\"Toronto\",\"state\":\"ON\",\"country\":\"Canada\"},\"categories\":[{\"id\":\"4bf58dd8d48988d16d941735\",\"name\":\"Café\",\"pluralName\":\"Cafés\",\"shortName\":\"Café\",\"icon\":{\"prefix\":\"https://ss1.4sqi.net/img/categories_v2/food/cafe_\",\"suffix\":\".png\"},\"primary\":true}],\"verified\":false,\"stats\":{\"checkinsCount\":3486,\"usersCount\":1893,\"tipCount\":71},\"likes\":{\"count\":24,\"groups\":[{\"type\":\"others\",\"count\":24,\"items\":[]}],\"summary\":\"24 likes\"},\"like\":false,\"beenHere\":{\"count\":1,\"marked\":false},\"storeId\":\"Brunswick House\"},\"likes\":{\"count\":0,\"groups\":[]},\"like\":false,\"photos\":{\"count\":0,\"items\":[]},\"posts\":{\"count\":0,\"textCount\":0},\"comments\":{\"count\":0},\"source\":{\"name\":\"foursquare for Android\",\"url\":\"https://foursquare.com/download/#/android\"}}]}}}", :headers => {})
  end

  before do
    foursquare_account.save
  end

  context "with a user" do
    describe ".places" do
      context "with { sync: true }" do
        it "requests .places_since self.synced_at" do
          FoursquareAccount.any_instance.should_receive(:places_since).with(foursquare_account.synced_at, {})
          foursquare_account.places({ sync: true })
        end
      end

      context "with { import: true }" do
        it "requests .places_since self.actived_at" do
          FoursquareAccount.any_instance.should_receive(:places_since).with(foursquare_account.activated_at, {})
          foursquare_account.places({ import: true })
        end
      end

      context "without options" do
        it "does not request .places_since" do
          FoursquareAccount.any_instance.should_not_receive(:places_since)
          foursquare_account.places
        end

        it "sends places response to .process_places" do
          FoursquareAccount.any_instance.should_receive(:process_places) # Arg is too long to define
          foursquare_account.places
        end
      end
    end

    describe ".places_since" do
      it "requests places from Foursquare API" do
        pending
      end
    end

    describe ".client" do
      it "returns a Foursquare2 authenticated user" do
        expect(
          foursquare_account.send(:client).class
        ).to eq(Foursquare2::Client)
      end
    end

    describe ".process_places" do
      pending
    end

    describe ".parse_created_at_with_time_zone_offset" do
      pending
    end
  end
end
