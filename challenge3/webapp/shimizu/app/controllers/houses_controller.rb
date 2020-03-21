class HousesController < ApplicationController
  def index
    @houses = House.all
    gon.energy_production_daylight = EnergyDataset.energy_production_daylight
  end

  def show
    @house = House.find(params[:id])
    gon.first_name = @house.first_name
    gon.energy_in_house = EnergyDataset.energy_in_house(params[:id]).values
    gon.overall_average = EnergyDataset.overall_average.values
    gon.month = EnergyDataset.overall_average.keys
  end
end
