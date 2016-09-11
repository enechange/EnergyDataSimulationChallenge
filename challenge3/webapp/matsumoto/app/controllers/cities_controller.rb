class CitiesController < ApplicationController
  def energies
    @chart = GraphService::Cities.temperature_scatter
  end
end
