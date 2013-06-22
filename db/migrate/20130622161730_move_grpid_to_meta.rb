class MoveGrpidToMeta < ActiveRecord::Migration
  def up
    Weight.all.each do |weight|
      if weight.grpid.present?
       weight.meta['grpid'] = weight.grpid
       weight.source = "WithingsAccount"
       weight.save
      end
    end
    remove_column :weights, :grpid
  end

  def down
    add_column :weights, :grpid, :integer
  end
end
