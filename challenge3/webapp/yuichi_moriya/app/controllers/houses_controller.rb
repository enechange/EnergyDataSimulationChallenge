class HousesController < ApplicationController
  def index
    @energies_by_city = House.monthly_energy_production_by_city
    @energies_by_city_and_family_structure = House.monthly_energy_production_by_city_and_family_structure
    @periods = Energy.group('year', 'month').order('year', 'month')
  end
end
