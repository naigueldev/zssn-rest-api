class Survivor < ActiveRecord::Base
  has_many :inventories
  accepts_nested_attributes_for :inventories, allow_destroy: true
  validates :name, :age, :gender, :latitude, :longitude, presence: true

  def infected?
    contamination_count >= 3
  end

  def infected_survivor
    self.is_infected = true if contamination_count == 3
    self.save
  end

end
