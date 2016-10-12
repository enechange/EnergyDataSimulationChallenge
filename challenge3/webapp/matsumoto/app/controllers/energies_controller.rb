class EnergiesController < ApplicationController
  before_action :set_energies, only: [:index]
  before_action :set_energy, only: [:show]
  def index
  end
  def show
  end

  private
  def set_energy
    @energy = Energy.find(params[:id])
  end
  def set_energies
    @energies = Energy.all
  end
end
