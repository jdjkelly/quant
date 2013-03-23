class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.float :value
      t.string :type

      t.timestamps
    end
  end
end
