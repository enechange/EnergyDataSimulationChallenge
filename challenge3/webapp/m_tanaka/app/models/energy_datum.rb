class EnergyDatum < ApplicationRecord
  belongs_to :house
  validates :label, presence: true
  validates :house_id, presence: true
  validates :year, presence: true
  validates :month, presence: true
  validates :temperature, presence: true
  validates :daylight, presence: true
  validates :energy_production, presence: true

  scope :with_house, -> {
    joins(:house)
  }

  scope :where_city, -> (city) {
    where(houses: { city: city })
  }

  scope :where_house, -> (id) {
    where(houses: { id: id })
  }

  scope :group_date, -> {
    group(:year, :month)
  }

  scope :average_energy, -> {
    average(:energy_production)
  }

  scope :average_city_energy_of, -> (city) {
    with_house.where_city(city).group_date.average_energy
  }

  scope :average_house_energy_of, -> (id) {
    with_house.where_house(id).group_date.average_energy
  }


end
