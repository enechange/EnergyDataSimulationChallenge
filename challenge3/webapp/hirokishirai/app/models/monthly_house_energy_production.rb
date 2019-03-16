class MonthlyHouseEnergyProduction < ApplicationRecord
  belongs_to :house

  validates :label, presence: true, numericality: { greater_than: 0, only_integer: true}
  validates :year, presence: true, numericality: { greater_than: 0, only_integer: true}
  validates :month, presence: true, numericality: { greater_than: 0, only_integer: true}
  validates :temperature, presence: true, numericality: { greater_than: 0 }
  validates :daylight, presence: true, numericality: { greater_than: 0 }
  validates :energy_production, presence: true, numericality: { greater_than: 0, only_integer: true}
end
