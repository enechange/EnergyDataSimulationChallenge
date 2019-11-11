class AverageByCitiesController < ApplicationController
  def index
    case params[:select]
    when "temperature"
      @temperature = AverageByCity.getTemperature
      render json: @temperature
    when "daylight"
      @daylight = AverageByCity.getDaylight
      render json: @daylight
    when "energy_production"
      @energy_production = AverageByCity.getEnergyProduction
      render json: @energy_production
    else
      render json: ["select=temperature or daylight or energy_production"]
    end
  end
end
