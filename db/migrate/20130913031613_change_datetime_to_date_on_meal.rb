class ChangeDatetimeToDateOnMeal < ActiveRecord::Migration
  def up
    connection = ActiveRecord::Base.connection()
    connection.execute "ALTER TABLE meals
                          ALTER COLUMN date SET DATA TYPE date"
  end

  def down
    connection = ActiveRecord::Base.connection()
    connection.execute "ALTER TABLE meals
                          ALTER COLUMN date SET DATA TYPE date timestamp without time zone;"
  end
end
