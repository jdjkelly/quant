class AddIndexToSleepsStart < ActiveRecord::Migration
  def change
    add_index :sleeps, :start
  end
end
