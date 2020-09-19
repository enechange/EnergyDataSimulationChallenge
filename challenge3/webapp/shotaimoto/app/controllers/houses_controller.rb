class HousesController < ApplicationController
  def index
    @houses = House.all.includes(:city)
    @cities = City.all
    @energy_productions_by_city = @cities.map{|city| {city: city.name, data:city.energies.group(:year, :month).sum(:energy_production)}}
  end

  def show
    @house = House.find(params[:id])
  end
end
