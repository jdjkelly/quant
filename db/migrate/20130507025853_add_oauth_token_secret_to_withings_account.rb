class AddOauthTokenSecretToWithingsAccount < ActiveRecord::Migration
  def change
    add_column    :withings_accounts, :oauth_token_secret, :string
  end
end
