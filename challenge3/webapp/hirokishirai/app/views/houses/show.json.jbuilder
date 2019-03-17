# frozen_string_literal: true

json.array! [
  ['x'] + @house.monthly_house_energy_productions.map { |ep| "#{ep[:year]}-#{format('%02d', ep[:month])}-01" }.uniq,
  [I18n.t('activerecord.attributes.monthly_house_energy_production.temperature')] + @house.monthly_average_temperatures.values,
  [I18n.t('activerecord.attributes.monthly_house_energy_production.daylight')] + @house.monthly_average_daylights.values,
  [I18n.t('activerecord.attributes.monthly_house_energy_production.energy_production')] + @house.monthly_average_energy_productions.values
]
