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

  def self.all_data
    position_data = []
    EnergyDetail.all.each do |e|
      position_data << e.scatter_position
    end
    ['All Data', '#ffea00', '#ffbb00', position_data]
  end

  def self.city_data(city)
    position_data = []
    energies = EnergyDetail.joins(:house).where(houses: { city: city })

    energies.each do |e|
      position_data << e.scatter_position
    end

    if city == 'cambridge'
      ['cambridge', '#ff3838', '#d10000', position_data]
    elsif city == 'london'
      ['london', '#ffea00', '#ffbb00', position_data]
    elsif city == 'oxford'
      ['oxford', '#00B8F5', '#0000F5', position_data]
    end
  end

  def scatter_position
    { x: daylight, y: energy_production }
  end
end
