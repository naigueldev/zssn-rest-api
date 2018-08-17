class InventorySerializer < ActiveModel::Serializer
  attributes :item, :points, :quantity
  belongs_to :survivor
end
