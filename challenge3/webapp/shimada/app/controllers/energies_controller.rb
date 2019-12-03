class EnergiesController < ApplicationController

  def index
    @daylights_by_city = Energy.statistical_data_by_city('total')
    @energies_by_city  = Energy.statistical_data_by_city

    energy_columns = Energy::PLUCK_KEYS
    @energies      = Energy.pluck_to_hash(energy_columns)
  end
end
