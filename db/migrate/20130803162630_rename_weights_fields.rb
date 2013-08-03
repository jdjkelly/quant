class RenameWeightsFields < ActiveRecord::Migration
  def change
    rename_column :weights, :lean_mass_value, :lean_mass
  end
end
