class EnergiesController < ApplicationController
  before_action :set_energy, only: [:show]

  def index
    @energies = Energy.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_energy
      @energy = Energy.find(params[:id])
    end

end
