class HousesController < ApplicationController
  def energies
    @houses_graph = GraphService::Houses.person_num_pie
  end
end
