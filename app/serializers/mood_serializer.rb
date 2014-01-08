class MoodSerializer < ActiveModel::Serializer
  attributes :id, :date, :rating, :description
end
