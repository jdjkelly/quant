class FoursquareAccount < ActiveRecord::Base
  include DataProvider

  attr_accessible :uid, :oauth_token

  validates_presence_of :uid, :oauth_token

  data_provider_for :places

  def places options={}

  end

  def places_since date=Date.current, options={}

  end

  private

  def client
    FoursquareAccount.authenticated_user self.id
  end

  def self.authenticated_user id
    user = FoursquareAccount.find id
  end
end
