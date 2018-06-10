class EnergyProductionsController < ApplicationController
  #before_action :set_energy_production, only: [:show, :edit, :update, :destroy]
  before_action :set_energy_production, only: [:show]

  # GET /energy_productions
  def index
    @energy_productions = EnergyProduction.all
  end

  # GET /energy_productions/1
  def show
  end

  # GET /energy_productions/new
  def new
    @energy_production = EnergyProduction.new
  end

  # GET /energy_productions/1/edit
  def edit
  end

  # POST /energy_productions
  def create
    @energy_production = EnergyProduction.new(energy_production_params)

    if @energy_production.save
      redirect_to @energy_production, notice: 'Energy production was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /energy_productions/1
  def update
    if @energy_production.update(energy_production_params)
      redirect_to @energy_production, notice: 'Energy production was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /energy_productions/1
  def destroy
    @energy_production.destroy
    redirect_to energy_productions_url, notice: 'Energy production was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy_production
      @energy_production = EnergyProduction.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def energy_production_params
      params.require(:energy_production).permit(:label, :house, :year, :month, :temperature, :daylight, :energy_production)
    end
end
