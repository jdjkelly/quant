class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.string :type
      t.integer :user_id
      t.float :bmi
      t.float :value
      t.float :lean_mass_value
      t.float :fat_mass_value
      t.float :fat_percentage
      t.datetime :recorded_at
      t.timestamps
    end
    add_index :weights, :user_id
  end
end
