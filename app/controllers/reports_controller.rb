class ReportsController < ApplicationController
  def infected_survivors
    render json: {
      percentage: Report.percentage(Survivor.infected_survivor_count / Survivor.all_survivors_count)
    }
  end
  def non_infected
    render json: {
      percentage: Report.percentage(Survivor.survivor_count / Survivor.all_survivors_count)
    }
  end
  def inventories_by_survivor
    render json: {
      water: Inventory.type_item("water").count.to_f / Survivor.survivor_count,
      food: Inventory.type_item("food").count.to_f / Survivor.survivor_count,
      medication: Inventory.type_item("medication").count.to_f / Survivor.survivor_count,
      ammunition: Inventory.type_item("ammunition").count.to_f / Survivor.survivor_count
    }
  end
  def lost_infected_points
    render json: {
      lostPoints: Report.lost_points 
    }
  end
end
