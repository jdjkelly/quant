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

Fabricator(:foursquare_account) do
  oauth_token         "0"
  uid                 "0"
  activated_at        Date.current
end
