class HouseEnergyUsagesController < ApplicationController
  def index
    @house_energy_usages = HouseEnergyUsage.all
  end

  def show
    @house_energy_usage = HouseEnergyUsage.find(params[:id])
  end
end
