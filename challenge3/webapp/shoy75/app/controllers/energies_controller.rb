class EnergiesController < ApplicationController
  def index
    @energies = Energy.all
  end
end
