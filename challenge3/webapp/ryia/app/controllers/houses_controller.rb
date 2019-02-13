class HousesController < ApplicationController
  def show
    @avg_daylight          = Energy.group(:month).average(:daylight)
    @avg_energy_production = Energy.group(:month).average(:energy_production)
    @avg_temperature       = Energy.group(:month).average(:temperature)
    @data                  = House.joins(:energies).select("houses.*, energies.*")
    @sum_energy_production = @data.group(:city).sum(:energy_production)
  end
end
