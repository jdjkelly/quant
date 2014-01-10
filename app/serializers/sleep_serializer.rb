class SleepSerializer < ActiveModel::Serializer
  attributes :id, :start, :end, :user_id
end
