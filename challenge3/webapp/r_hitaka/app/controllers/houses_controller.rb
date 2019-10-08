class HousesController < ApplicationController
  before_action :set_house, only: %(show)
  def index
    @houses = House.all
  end

  def show
    years = Energy.years
    @chart_energies = Energy.chart_energies_production(params[:id])
    @chart_energies_avg = Energy.chart_energies_average(params[:id])
    @chart_daylights = Energy.chart_daylight(params[:id])
  end

  def import
    House.import(params[:file])
    redirect_to energy_houses_path
  end

  private

  def set_house
    @house = House.find(params[:id])
  end
end
