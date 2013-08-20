class MealSerializer < ActiveModel::Serializer
  attributes :id, :date, :calories, :carbohydrates, :fat, :protein,
             :carbohydrates_percentage, :fat_percentage, :protein_percentage
end
