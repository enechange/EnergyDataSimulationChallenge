class HomeController < ApplicationController
  def index
    @houses = House.all
    gon.energies = Energy.all.map(&:chart_data)
    gon.city_energy_production = Energy.city_energy_production
  end

  def show
    @house = House.find(params[:id])
  end
end
