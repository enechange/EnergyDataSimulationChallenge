class CitiesController < ApplicationController
  def index
    @cities = City.all

    @average_energies_by_city = []
    @cities.each do |city|
      avg = Energy.joins(:house).where(houses: {city_id: city.id}).order(:year,:month).group(:year, :month).average(:energy_production)
      @average_energies_by_city << { name: city.name, data: avg }
    end
  end

  def show
    @city = City.find(params[:id])
    @houses = @city.houses
    @chart_data = @houses.joins(:energies).pluck(:daylight, :energy_production)
  end
end
