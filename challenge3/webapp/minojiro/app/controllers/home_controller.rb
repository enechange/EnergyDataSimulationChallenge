class HomeController < ApplicationController
  def index
    gon.energies = Energy.all.map(&:chart_data)
    gon.city_energy_production = Energy.city_energy_production
  end
end
