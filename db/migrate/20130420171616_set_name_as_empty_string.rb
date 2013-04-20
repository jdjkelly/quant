class SetNameAsEmptyString < ActiveRecord::Migration
  def up
    User.all.each do |user|
      user.update_column(:name, "User")
    end
  end
end

