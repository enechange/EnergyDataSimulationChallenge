class EnergyProductionDataset < ApplicationRecord
  belongs_to :house_dataset

  validates :label,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :year,
            presence: true,
            numericality: { only_integer: true },
            length: { is: 4 }
  validates :month,
            presence: true,
            inclusion: { in: 1..12 }
  validates :temperature,
            presence: true,
            numericality: true
  validates :daylight,
            presence: true,
            numericality: true
  validates :energy_production,
            presence: true,
            numericality: { only_integer: true }
end
