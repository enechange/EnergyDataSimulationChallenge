class HousesController < ApplicationController
  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    @london_average = EnergyDatum.average_city_energy_of('London')
    @oxford_average = EnergyDatum.average_city_energy_of('Oxford')
    @cambridge_average = EnergyDatum.average_city_energy_of('Cambridge')
    @house_average = EnergyDatum.average_house_energy_of(params[:id])
  end
end
