class AddMetaToWeight < ActiveRecord::Migration
  def change
    add_column :weights, :meta, :hstore
    add_hstore_index :weights, :meta
  end
end
