class CreateFitbitAccounts < ActiveRecord::Migration
  def change
    create_table :fitbit_accounts do |t|
      t.string  :uid
      t.string  :oauth_token
      t.string  :oauth_token_secret
      t.integer :user_id
      t.timestamps
    end
    add_index :fitbit_accounts, :user_id
  end
end
