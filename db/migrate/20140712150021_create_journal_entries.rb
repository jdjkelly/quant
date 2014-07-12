class CreateJournalEntries < ActiveRecord::Migration
  def change
    create_table :journal_entries do |t|
      t.datetime :recorded_at
      t.string :feelings
      t.integer :happiness
      t.string :strategies

      t.timestamps
    end
  end
end
