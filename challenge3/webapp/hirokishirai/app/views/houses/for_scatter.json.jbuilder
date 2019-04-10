# frozen_string_literal: true

json.array! [
  [I18n.t('activerecord.attributes.monthly_house_energy_production.temperature')] + @house.monthly_house_energy_productions.order_by_month.map(&:temperature),
  [I18n.t('activerecord.attributes.monthly_house_energy_production.energy_production')] + @house.monthly_house_energy_productions.order_by_month.map(&:energy_production)
]
