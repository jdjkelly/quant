class MealSerializer < ActiveModel::Serializer
  attributes :id, :date, :calories, :carbohydrates_percantage, :fat_percentage,
             :protein_percentage
end
