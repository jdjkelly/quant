class RemoveMoods < ActiveRecord::Migration
  def up
    drop_table :moods
  end
end
