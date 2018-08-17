class Survivor < ActiveRecord::Base
  has_many :inventories
  accepts_nested_attributes_for :inventories, allow_destroy: true
  validates :name, :age, :gender, :latitude, :longitude, presence: true

end
