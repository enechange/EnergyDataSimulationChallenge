class EnergyProduction < ApplicationRecord
  belongs_to :house_energy_usage, foreign_key: 'house'

  def date_label
    "#{year}/#{month}"
  end
end
