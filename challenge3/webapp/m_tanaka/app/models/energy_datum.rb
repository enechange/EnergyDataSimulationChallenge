class EnergyDatum < ApplicationRecord
  belongs_to :house
  validates :label, presence: true
  validates :house_id, presence: true
  validates :year, presence: true
  validates :month, presence: true
  validates :temperature, presence: true
  validates :daylight, presence: true
  validates :energy_production, presence: true

end
