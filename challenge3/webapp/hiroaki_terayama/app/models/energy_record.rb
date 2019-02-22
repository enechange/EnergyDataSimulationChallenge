class EnergyRecord < ApplicationRecord
  belongs_to :house

  validates :origin_id, presence: true, numericality: { only_integer: true }
  validates :label, presence: true, numericality: { only_integer: true }
  validates :house, presence: true, numericality: { only_integer: true }
  validates :year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :month, presence: true, numericality: { only_integer: true }, length: { in: 1..2 }
  validates :temperature, presence: true, numericality: { only_integer: false }
  validates :day_light, presence: true, numericality: { only_integer: false }
end
