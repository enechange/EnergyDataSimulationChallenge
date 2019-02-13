class HouseEnergyUsagesController < ApplicationController
  def index
    @house_energy_usages = HouseEnergyUsage.all
  end

  def show
    @house_energy_usage = HouseEnergyUsage.find(params[:id])
    gon.date_label = @house_energy_usage.energy_productions.map(&:date_label)
    gon.energy_production = @house_energy_usage.energy_productions.map(&:energy_production)
    gon.daylight = @house_energy_usage.energy_productions.map(&:daylight)
  end
end
