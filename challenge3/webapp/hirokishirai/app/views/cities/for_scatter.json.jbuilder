# frozen_string_literal: true

json.array! [
  [I18n.t('activerecord.attributes.monthly_house_energy_production.temperature')] + @city.monthly_house_energy_productions.pluck(:temperature),
  [I18n.t('activerecord.attributes.monthly_house_energy_production.energy_production')] + @city.monthly_house_energy_productions.pluck(:energy_production)
]
