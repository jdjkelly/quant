class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime        :date
      t.integer         :calories
      t.integer         :carbohydrates
      t.integer         :protein
      t.integer         :fat
      t.integer         :user_id
      t.string          :description, limit: 255

      t.timestamps
    end
    add_index :meals, :user_id
  end
end
