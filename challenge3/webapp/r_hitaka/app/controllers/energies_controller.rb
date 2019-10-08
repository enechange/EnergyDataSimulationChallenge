class EnergiesController < ApplicationController
  def index
    @energies = Energy.all
  end

  def import
    Energy.import(params[:file])
    redirect_to energies_path
  end
end