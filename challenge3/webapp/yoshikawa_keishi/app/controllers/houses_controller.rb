class HousesController < ApplicationController

  def index
    @houses = House.all
    @daylight_energy_data = Datum.pluck(:daylight, :energy_production)
    @city_energy_production = Datum.city_energy_production
  end

  def show
    @house = House.find(params[:id])
    @house_data = @house.data
    @house_monthly_data = @house.monthly_data
  end

end
