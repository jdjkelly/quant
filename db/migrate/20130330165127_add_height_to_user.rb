class AddHeightToUser < ActiveRecord::Migration
  def change
    add_column :users, :height, :decimal
  end
end
