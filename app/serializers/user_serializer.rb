class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :height, :sex
end
