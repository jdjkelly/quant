class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :date, :lat, :lng
end
