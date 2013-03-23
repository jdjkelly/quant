class CreateWithingsAccounts < ActiveRecord::Migration
  def change
    create_table :withings_accounts do |t|
      t.string :uid

      t.timestamps
    end
  end
end
