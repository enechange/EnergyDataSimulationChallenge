# frozen_string_literal: true

json.array! [
  ['x'] + @city.monthly_house_energy_productions.order_by_month.map { |ep| "#{ep[:year]}-#{format('%02d', ep[:month])}-01" }.uniq,
  [I18n.t('activerecord.attributes.monthly_house_energy_production.temperature')] + @city.monthly_average_temperatures.values,
  [I18n.t('activerecord.attributes.monthly_house_energy_production.daylight')] + @city.monthly_average_daylights.values,
  [I18n.t('activerecord.attributes.monthly_house_energy_production.energy_production')] + @city.monthly_average_energy_productions.values
]
