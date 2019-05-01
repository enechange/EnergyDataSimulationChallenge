class EnergiesController < ApplicationController

  def index
    @energies = Energy.all
  end

  def show
    @energy = Energy.find(params[:id])
  end

end
