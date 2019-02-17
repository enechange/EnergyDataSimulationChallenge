class Energy < ApplicationRecord
  belongs_to :house

  validates :label, presence: true, numericality: { only_integer: true }
  validates :house_id, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 13 }
  validates :temperature, presence: true
  validates :daylight, presence: true
  validates :energy_production, presence: true, numericality: { only_integer: true }
end
