class SurvivorsController < ApplicationController
  before_action :find_survivor, only: [:show, :update, :destroy, :report_infection]

  # GET /survivors
  def index
    @survivors = Survivor.all
    render json: @survivors
  end
  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)

    if @survivor.save
      render json: @survivor, status: :created, location: @survivor
    else
      render json: @survivor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /survivors/:id
  def update
    if update_params.present?
      @survivor.update_attributes(latitude: update_params[:latitude], longitude: update_params[:longitude])
      head :no_content
    end
  end


  def destroy
    @survivor.destroy
  end

  private
  def find_survivor
    @survivor = Survivor.find(params[:id])
  end

  def survivor_params
    params.permit(:name, :age, :gender, :latitude, :longitude, :inventories_attributes=>[:survivor_id, :item, :points, :quantity])
  end

  def update_params
    params.require(:survivor).permit(:latitude, :longitude)
  end

end
