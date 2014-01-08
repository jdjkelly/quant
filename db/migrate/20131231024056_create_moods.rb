class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.datetime    :date
      t.integer     :user_id
      t.decimal     :rating
      t.text        :description

      t.timestamps
    end
  end
end
