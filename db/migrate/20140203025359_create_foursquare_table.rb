class CreateFoursquareTable < ActiveRecord::Migration
  def change
    create_table :foursquare_accounts do |t|
      t.string   :uid
      t.string   :oauth_token
      t.datetime :activated_at
      t.datetime :synced_at
      t.integer  :user_id
      t.timestamps
    end
    add_index :foursquare_accounts, :user_id

    add_column :places, :meta, :hstore
    add_column :places, :source, :string
    add_column :places, :response, :json
    add_hstore_index :places, :meta
  end
end
