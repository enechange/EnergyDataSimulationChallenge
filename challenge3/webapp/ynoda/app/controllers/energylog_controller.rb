class EnergylogController < ApplicationController
  protect_from_forgery
  def show
    @energylog = Energylog.order(:id)
  end
end
