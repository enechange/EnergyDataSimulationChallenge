class HousesController < ApplicationController
  def index
    @houses = House.eager_load(:city, :energies)
    @houses_data = HouseChartService.call(@houses)
  end
end
