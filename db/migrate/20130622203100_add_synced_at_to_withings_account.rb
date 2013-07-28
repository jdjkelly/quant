class AddSyncedAtToWithingsAccount < ActiveRecord::Migration
  def change
    add_column :withings_accounts, :synced_at, :datetime
  end
end
