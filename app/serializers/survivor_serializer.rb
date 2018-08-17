class SurvivorSerializer < ActiveModel::Serializer
  attributes :name, :age, :gender, :latitude, :longitude, :is_infected
  has_many :inventories
end
