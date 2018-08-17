class SurvivorsController < ApplicationController
  before_action :find_survivor, only: [:show, :update, :destroy, :report_infection]

  # GET /survivors
  def index
    @survivors = Survivor.all
    render json: @survivors
  end
  # GET /survivors/:id
  def show
    render json: @survivor
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

  # POST /survivors/:id/flag_infection
  def flag_infection
    # @survivor.inc(infection_count: 1)

    if @survivor.infected?
      render json: { message: "Warning! Infected survivor reported as infected #{@survivor.infection_count} time(s)!" }, status: :ok
    else
      render json: { message: "Attention! Survivor was reported as infected #{@survivor.infection_count} time(s)!" },status: :ok
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
