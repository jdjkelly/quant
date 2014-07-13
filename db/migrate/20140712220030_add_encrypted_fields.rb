class AddEncryptedFields < ActiveRecord::Migration
  def change
    add_column :journal_entries, :encrypted_happiness, :string
    add_column :journal_entries, :encrypted_strategies, :text
    add_column :journal_entries, :encrypted_feelings, :text

    remove_column :journal_entries, :recorded_at, :datetime
  end
end
