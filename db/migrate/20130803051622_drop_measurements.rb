class DropMeasurements < ActiveRecord::Migration
  def up
    drop_table :measurements
  end
end
