class AddGrpidToWeightsTable < ActiveRecord::Migration
  def change
    add_column    :weights, :grpid, :integer
  end
end
