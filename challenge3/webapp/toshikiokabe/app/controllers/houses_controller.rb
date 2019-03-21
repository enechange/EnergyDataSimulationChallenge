class HousesController < ApplicationController
  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])

    gon.year_month = @house.energies.time_series.map(&:year_month)
    gon.energy_production = @house.energies.time_series.pluck(:energy_production)
    gon.daylight = @house.energies.time_series.pluck(:daylight)
  end
end
