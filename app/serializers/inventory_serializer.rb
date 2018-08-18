class InventorySerializer < ActiveModel::Serializer
  attributes :item, :quantity, :points
  belongs_to :survivor
end
