class RenameWeightsFields < ActiveRecord::Migration
  def change
    rename_column :weights, :lean_mass_value, :lean_mass
    rename_column :weights, :fat_mass_value, :fat_mass
    rename_column :weights, :fat_percentage, :fat_percent
  end
end
