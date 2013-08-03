class RenameLocationsToPlaces < ActiveRecord::Migration
  def change
    rename_table :locations, :places
  end
end
