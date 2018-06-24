class ApplicationController < ActionController::Base
  def index
    @energy_productions = EnergyProduction.all
  end
end
