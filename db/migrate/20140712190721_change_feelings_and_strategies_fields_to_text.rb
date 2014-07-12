class ChangeFeelingsAndStrategiesFieldsToText < ActiveRecord::Migration
  def change
  	change_column :journal_entries, :strategies, :text
  	change_column :journal_entries, :feelings, :text
  end
end
