class Survivor < ActiveRecord::Base
  has_many :inventories, dependent: :delete_all
  accepts_nested_attributes_for :inventories
  validates :name, :age, :gender, :latitude, :longitude, presence: true


  def set_points(survivor)
    survivor.inventories.each do |inventory|
      inventory_item = inventory[:item].downcase
      data = JSON.parse(Inventory.list_items)
      data.each do |item|
        @value = item["points"]if inventory_item.eql?(item["item"].downcase)
      end
      calc = @value * inventory[:quantity]
      inventory[:points] = calc
    end
  end
  def infected?
    contamination_count >= 3
  end
  def infected_survivor
    self.is_infected = true if contamination_count == 3
    self.save
  end
  def has_inventories?(survivor,inventory_param)
    has_item = false
    survivor.inventories.each do |inventory|
      has_item = true if inventory_param['item'].downcase.eql?(inventory['item'].downcase)
      return has_item if has_item.present?
    end
    return has_item
  end
  def has_enought_inventories?(survivor , inventory_param)
    survivor.inventories.each do |inventory|
      return false if inventory['quantity'].to_i < inventory_param['quantity'].to_i && inventory_param['item'].downcase.eql?(inventory['item'].downcase)
    end
    return true
  end
  def update_points(survivor)
    survivor.inventories.each do |inventory|
      inventory_item = inventory[:item].downcase
      data = JSON.parse(Inventory.list_items)
      data.each do |item|
        @value = item["points"]if inventory_item.eql?(item["item"].downcase)
      end
      calc = @value * inventory[:quantity]
      inventory.update(points:calc)
    end
  end
  def transfer_item_to(target_survivor, inventory_items)
    inventory_items.each do |inventory, quantity|
      self_inventory_item = self.inventories.find_by(item: inventory['item'])
      quantity_removed = self_inventory_item.quantity - inventory['quantity'].to_i
      if quantity_removed > 0
        self_inventory_item.update(quantity: quantity_removed)
        self.update_points(self)
      else
        self_inventory_item.destroy
      end
      unless target_survivor.inventories.where(item: inventory['item']).exists?
        target_survivor.inventories.create(item:inventory['item'], quantity: inventory['quantity'])
        target_survivor.set_points(target_survivor)
        target_survivor.save
      else
        new_quantity = self_inventory_item.quantity.to_i - inventory['quantity'].to_i
        if new_quantity > 0
          target_survivor.inventories.where(item:inventory['item']).update_all(quantity: new_quantity)
          target_survivor.update_points(target_survivor)
        else
          inventory_item_target = target_survivor.inventories.find_by(item:inventory['item'])
          inventory_item_target.destroy
        end
      end
    end
  end


  def self.infected_survivor_count
    self.infecteds.count.to_f
  end
  def self.all_survivors_count
    self.all.count.to_f
  end
  def self.survivor_count
    self.not_infected.count.to_f
  end
  def self.infected_survivors
    percentage(infecteds.size)
  end

  def uninfected_survivors
    percentage(uninfecteds.size)
  end

  def points_lost
    points_lost = infecteds.sum(:points)
    return "#{points_lost} points lost due to #{infecteds.size} infected survivors."
  end


  def percentage(part)
    whole = Survivor.all.size
    return ((part.to_f / whole.to_f) * 100).round(3).to_s + "%"
  end

  def self.infecteds
    where(is_infected: true)
  end

  def self.not_infected
    where(is_infected: false)
  end
end
