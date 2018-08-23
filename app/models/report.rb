class Report
  def self.percentage(number)
    "#{(number.round(4) * 100).round(2)}%"
  end
  def self.lost_points
    Inventory.where(survivor_id: Survivor.infecteds).map(&:points).inject(:+)
  end
end
