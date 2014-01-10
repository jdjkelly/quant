class CreateSleeps < ActiveRecord::Migration
  def change
    create_table :sleeps do |t|
      t.datetime :start
      t.datetime :end
      t.integer :user_id

      t.timestamps
    end
  end
end
