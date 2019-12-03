class HomeController < ApplicationController
  def index
    @houses = House.all
    gon.daylight_energy_production = Energy.daylight_energy_production
    gon.city_energy_production = Energy.city_energy_production
  end

  def show
    @house = House.find(params[:id])
  end
end
