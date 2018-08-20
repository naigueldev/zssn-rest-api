class Inventory < ActiveRecord::Base
  belongs_to :survivor

  def self.list_items
    list = [
      {
        "item"    => "water",
        "points"  => 4
      },
      {
        "item"    => "food",
        "points"  => 3
      },
      {
        "item"    => "medication",
        "points"  => 2
      },
      {
        "item"    => "ammunition",
        "points"  => 1
      }
    ].to_json
  end

  def self.type_item(type)
    where('lower(item) = ?', type.downcase)
  end
end
