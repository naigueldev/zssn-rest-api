class AddSurvivorRefToInventories < ActiveRecord::Migration
  def change
    add_reference :inventories, :survivor, index: true, foreign_key: true
  end
end
