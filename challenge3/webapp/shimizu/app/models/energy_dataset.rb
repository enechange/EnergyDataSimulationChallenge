class EnergyDataset < ApplicationRecord
  belongs_to :house

  validates :label, presence: true
  validates :house_id, presence: true
  validates :year, presence: true
  validates :month, presence: true
  validates :temperature, presence: true
  validates :daylight, presence: true
  validates :energy_production, presence: true

  scope :average_energy, -> {
    group(:year, :month).average(:energy_production)
  }

  scope :energy_in_house, -> (id) {
    includes(:house).where(houses: { id: id }).average_energy
  }
end
