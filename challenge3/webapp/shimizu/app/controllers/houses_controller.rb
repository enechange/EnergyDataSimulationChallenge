class HousesController < ApplicationController
  def index
    @houses = House.all
    @scatter_data = EnergyDataset.pluck(:daylight, :energy_production)
  end

  def show
    @house = House.find(params[:id])
    @average_energy_in_all_house = EnergyDataset.average_energy
    @energy_in_house = EnergyDataset.energy_in_house(params[:id])
  end
end
