class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :user_id
      t.datetime :recorded_at
      t.decimal :lat
      t.decimal :lng
      t.timestamps
    end
    add_earthdistance_index :locations
  end
end
