class HousesController < ApplicationController

  def index
    @houses = House.all
    @data = Datum.pluck(:daylight, :energy_production)
    @city_energy_production = Datum.city_energy_production
  end

  def show
    @house = House.find(params[:id])
    @data = @house.data
    @monthly_data = @house.monthly_sort
  end

end
