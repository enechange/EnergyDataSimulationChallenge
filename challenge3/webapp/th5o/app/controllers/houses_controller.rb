class HousesController < ApplicationController
  before_action :set_house, only: [:show]

  def index
    @houses = House.all
  end

  def show
    @energies_for_gchart = [["Date", "Energy Production"]] +
      @house.energies.map{|e| ["#{e.year}-#{e.month}", e.energy_production]}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_house
      @house = House.find(params[:id])
    end

end
