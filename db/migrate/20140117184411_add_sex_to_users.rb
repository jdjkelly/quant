class AddSexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sex, :char, :limit => 1
  end
end
