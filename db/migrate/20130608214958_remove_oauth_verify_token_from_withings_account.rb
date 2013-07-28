class RemoveOauthVerifyTokenFromWithingsAccount < ActiveRecord::Migration
  def change
    remove_column :withings_accounts, :oauth_verifier
  end
end
