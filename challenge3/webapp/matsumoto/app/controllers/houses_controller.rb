class HousesController < ApplicationController
  def energies
    @chart = GraphService::Houses.person_num_pie
  end
end
