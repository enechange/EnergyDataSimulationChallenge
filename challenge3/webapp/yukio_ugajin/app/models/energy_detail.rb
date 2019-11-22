class EnergyDetail < ApplicationRecord
  # Association
  belongs_to :house

  # Validation
  validates :label, 
            presence: true, numericality: { only_integer: true }
  validates :year,
            presence: true, numericality: { only_integer: true }
  validates :month,
            presence: true, numericality: { only_integer: true }
  validates :temperture,
            presence: true, numericality: true
  validates :daylight,
            presence: true, numericality: true
  validates :energy_production,
            presence: true, numericality: { only_integer: true }

  def scatter_position
    { x: daylight, y: energy_production }
  end
end
