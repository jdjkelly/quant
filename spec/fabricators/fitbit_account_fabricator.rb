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

Fabricator(:fitbit_account) do
  oauth_token         "0"
  oauth_token_secret  "0"
  uid                 "0"
  activated_at        Date.current
end
