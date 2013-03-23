class AddUserIdToMeasurement < ActiveRecord::Migration
  def change
    add_column :measurements, :user_id, :integer
    add_index :measurements, :user_id
  end
end
