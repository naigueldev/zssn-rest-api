class TradesController < ApplicationController
  def trade
    trade = Trade.new(trade_params)
    if trade.process
      render json: { message: trade.message }, status: :ok
    else
      render json: { error: trade.message }, status: trade.status
    end
  end
  private
  def trade_params
    params.require(:trade).permit(survivor_one: [:id, inventories: [:item, :quantity]],
      survivor_two: [:id, inventories: [:item, :quantity]])
  end
end
