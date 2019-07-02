class HomeController < ApplicationController
  def index
    @monthly_energy_logs = MonthlyEnergyLogsFinder.averages
    @energies_by_city = MonthlyEnergyLogsFinder.by_city
  end
end
