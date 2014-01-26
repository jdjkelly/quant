class AddMetaToSleep < ActiveRecord::Migration
  def change
    add_column :sleeps, :meta, :hstore
    add_column :sleeps, :source, :string
    add_hstore_index :sleeps, :meta
  end
end
