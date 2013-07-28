class AddSourceToWeights < ActiveRecord::Migration
  def change
    add_column :weights, :source, :string
  end
end
