class EnergyProductionsController < ApplicationController
  before_action :set_energy_production, only: [:show, :update, :destroy]

  # GET /energy_productions
  def index
    @energy_productions = EnergyProduction.all

    render json: @energy_productions
  end

  # GET /energy_productions/1
  def show
    render json: @energy_production
  end

  # POST /energy_productions
  def create
    @energy_production = EnergyProduction.new(energy_production_params)

    if @energy_production.save
      render json: @energy_production, status: :created, location: @energy_production
    else
      render json: @energy_production.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /energy_productions/1
  def update
    if @energy_production.update(energy_production_params)
      render json: @energy_production
    else
      render json: @energy_production.errors, status: :unprocessable_entity
    end
  end

  # DELETE /energy_productions/1
  def destroy
    @energy_production.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy_production
      @energy_production = EnergyProduction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_production_params
      params.require(:energy_production).permit(:label, :house_id, :year, :month, :temperature, :daylight, :energy_production)
    end
end
