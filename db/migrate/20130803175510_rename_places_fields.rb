class RenamePlacesFields < ActiveRecord::Migration
  def change
    rename_column :places, :recorded_at, :date
  end
end
