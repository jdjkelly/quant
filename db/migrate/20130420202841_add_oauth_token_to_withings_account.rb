class AddOauthTokenToWithingsAccount < ActiveRecord::Migration
  def change
    add_column    :withings_accounts, :oauth_token, :string
    add_column    :withings_accounts, :oauth_verifier, :string
    rename_column :withings_accounts, :uid, :userid
    add_column    :withings_accounts, :user_id, :integer
    add_index     :withings_accounts, :user_id
  end
end
