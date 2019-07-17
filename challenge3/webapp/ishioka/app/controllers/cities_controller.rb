class CitiesController < ApplicationController
  def index
    @cities = City.all
    @average_energies = City.average_energies_in_all_city
  end

  def show
    @city = City.find(params[:id])
    @houses = @city.houses
    @chart_data = @houses.with_house.pluck(:daylight, :energy_production)
  end
end
