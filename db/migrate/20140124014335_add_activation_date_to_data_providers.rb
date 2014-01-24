class AddActivationDateToDataProviders < ActiveRecord::Migration
  def change
    add_column :fitbit_accounts, :activated_at, :datetime
    add_column :withings_accounts, :activated_at, :datetime
  end
end
