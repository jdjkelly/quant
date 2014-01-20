class AddSyncedAtToFitbitAccount < ActiveRecord::Migration
  def change
    add_column :fitbit_accounts, :synced_at, :datetime
  end
end
