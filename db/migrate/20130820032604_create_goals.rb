class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string      :type
      t.datetime    :start
      t.datetime    :end
      t.integer     :user_id
      t.timestamps
    end
  end
end
