class SurvivorSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender, :latitude, :longitude, :is_infected, :contamination_count
  has_many :inventories
end
