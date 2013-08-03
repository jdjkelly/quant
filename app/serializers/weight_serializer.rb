class WeightSerializer < ActiveModel::Serializer
  attributes :id, :bmi, :value, :lean_mass, :fat_mass, :fat_percent, :date
end
