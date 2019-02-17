class TemperatureChartsController < ApplicationController
  def show
    gon.temperature = []
    gon.energy_production = []
    Energy.pluck(:temperature, :energy_production).each do |data|
      gon.temperature << data[0]
      gon.energy_production << data[1]
    end
  end
end
