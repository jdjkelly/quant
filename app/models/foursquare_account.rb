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

class FoursquareAccount < ActiveRecord::Base
  include DataProvider

  attr_accessible :uid, :oauth_token, :user

  validates_presence_of :uid, :oauth_token

  data_provider_for :places

  def places options={}
    if options[:import] == true && self.activated_at.present?
      places_since self.activated_at, options.except(:import)
      return
    elsif options[:sync] == true && self.synced_at.present?
      places_since self.synced_at, options.except(:sync)
      return
    end

    # TODO: This needs to be wrapped in an external API rescue so that
    # failures are handled gracefully
    response = client.user_checkins options.except(:sync, :import)
    process_places response["items"]
  end

  def places_since date=Date.current, options={}
    date = date.to_i
    count = client.user_checkins({afterTimestamp: date})["count"]

    if count > 250
      offset = 0
      while count < offset
        places({afterTimestamp: date, limit: 250, offset: offset}.merge(options))
        offset += 250
      end
    else
      places({afterTimestamp: date, limit: 250}.merge(options))
    end
  end

  private

  def client
    FoursquareAccount.authenticated_user self.id
  end

  def self.authenticated_user id
    user = FoursquareAccount.find id
    Foursquare2::Client.new(oauth_token: user.oauth_token, api_version: '20140128')
  end

  def process_places places
    raise ArgumentError "places must be an array" unless places.is_a? Array || places.nil?

    places.each do |place|
      # Proceed to next place if a version with the same meta id exists
      next if user.places.where("meta @> 'id=>#{place[:id.to_s].to_s}'").first
      # Proceed to next place if no venue data is available
      next if !place["venue"].present?

      user.places.create(
        date: parse_created_at_with_time_zone_offset(place["createdAt"].to_i, place["timeZoneOffset"]),
        lat: place["venue"]["location"]["lat"],
        lng: place["venue"]["location"]["lng"],
        source: self.class.to_s,
        meta: {
          id: place["id"]
        },
        response: place
      )
    end
  end

  def parse_created_at_with_time_zone_offset created_at, time_zone_offset
    time = Time.use_zone("UTC") { Time.zone.at(created_at.to_i) }
    time + (time_zone_offset / 60).hours
  end
end
