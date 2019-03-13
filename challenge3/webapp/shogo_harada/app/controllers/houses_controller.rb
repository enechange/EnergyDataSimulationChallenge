class HousesController < ApplicationController
  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    @show_energies = @house.energy_usages.order(:house_id, :label)
    @all_energies = EnergyUsage.all
  end
end
