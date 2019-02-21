class HousesController < ApplicationController
  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    @energies = @house.energies.order(:id)
    gon.month = []
    gon.energy_production = []
    @energies.each do |energy|
      gon.month << "#{energy.year}/#{energy.month}"
      gon.energy_production << energy.energy_production
    end
  end
end
