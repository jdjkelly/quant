# == Schema Information
#
# Table name: withings_accounts
#
#  id         :integer          not null, primary key
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class WithingsAccount < ActiveRecord::Base
  attr_accessible :uid

  belongs_to :user
end


@callback_url = "http://127.0.0.1:3000/oauth/callback"
@consumer = OAuth::Consumer.new(Settings.withings_oauth_key, Settings.withings_oauth_secret, {
  :site => "https://oauth.withings.com/",
  :request_token_path => '/oauth/request_token',
  :authorize_path     => '/oauth/authorize',
  :access_token_path  => '/oauth/access_token',
  :http_method   => :get
})

