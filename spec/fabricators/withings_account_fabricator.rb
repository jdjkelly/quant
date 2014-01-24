# == Schema Information
#
# Table name: withings_accounts
#
#  id                 :integer          not null, primary key
#  userid             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  oauth_token        :string(255)
#  user_id            :integer
#  oauth_token_secret :string(255)
#  synced_at          :datetime
#  activated_at       :datetime
#

Fabricator(:withings_account) do
  oauth_token "0"
  oauth_token_secret "0"
  userid "0"
end
