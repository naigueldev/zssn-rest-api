class Trade
  attr_accessor :status, :message
  def initialize(params)
    @message = ""
    @status = nil
    @trade_params = [params[:survivor_one], params[:survivor_two]]
    @survivor_one_id = params[:survivor_one][:id].to_i
    @survivor_two_id = params[:survivor_two][:id].to_i
    @survivor_one = @survivor_two = nil
    @survivor_one_inventories_params = params[:survivor_one][:inventories]
    @survivor_two_inventories_params = params[:survivor_two][:inventories]
  end
  def process
    validate_survivors
    validate_infection
    validate_inventories
    validate_points
    trade_inventories_items
    rescue Exception => error
    @status  = :conflict if @status.nil?
    @message = error.message
    return false
  end
  private
  def validate_survivors
    if Survivor.exists?(id: @survivor_one_id.to_i) && Survivor.exists?(id: @survivor_two_id.to_i)
      is_different_survivor?(@survivor_one_id,@survivor_two_id)
    else
      id = []
      id << @survivor_one_id unless Survivor.exists?(id: @survivor_one_id)
      id << @survivor_two_id unless Survivor.exists?(id: @survivor_two_id)
      @status  = :not_found
      raise "Survivor with id #{id} cannot be found in the system"
    end
  end
  def validate_infection
    survivors.each do |survivor|
      if survivor.is_infected?
        raise "Survivor with id=#{survivor.id} Name='#{survivor.name.to_s.titleize}' is infected!"
      end
    end
  end
  def validate_inventories
    survivors.each_with_index do |survivor, index|
      inventories_params = @trade_params[index]['inventories']
      inventories_params.each do |inventory_param|
        unless survivor.has_inventories?(survivor,inventory_param)
          raise "Item '#{inventory_param['item']}' dos not belong to survivor with id=#{survivor.id}"
        end
        unless survivor.has_enought_inventories?(survivor,inventory_param)
          raise "Survivor with id='#{survivor.id}' doesn't have enough item='#{inventory_param['item']}' "
        end
      end  unless inventories_params.nil?
    end
  end
  def validate_points
    total_points = []
    survivors.each_with_index do |survivor, index|
      sum_points = 0
    	inventories = @trade_params[index]['inventories']
      inventories.each do |inventory|
        value = nil
        item = inventory[:item].downcase
        data = JSON.parse(Inventory.list_items)
        data.each do |elem|
          value = elem["points"] if item.eql?(elem["item"].downcase)
          break if value.present?
        end
        calc = value * inventory[:quantity]
        sum_points += calc
      end
      total_points << sum_points
    end
    if total_points[0] != total_points[1]
      @status = :bad_request
      raise "Both sides of the trade should offer the same amount of points."
    end
  end
  def trade_inventories_items
    @survivor_one.transfer_item_to(@survivor_two, @trade_params[0]['inventories'])
    @survivor_two.transfer_item_to(@survivor_one, @trade_params[1]['inventories'])
    @status  = :success
    @message = 'Trade successfully completed'
  end
  def is_different_survivor?(survivor_one_id,survivor_two_id)
    raise "The trade requires two different survivors." if survivor_one_id == survivor_two_id
    @survivor_one = Survivor.find(survivor_one_id)
    @survivor_two = Survivor.find(survivor_two_id)
  end
  def survivors
    [@survivor_one, @survivor_two]
  end
end
