class CitiesController < ApplicationController
  def energies
    @cities_graph = GraphService::Cities.temperature_scatter
  end
end
