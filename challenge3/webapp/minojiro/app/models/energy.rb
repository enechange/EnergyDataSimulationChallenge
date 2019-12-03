class Energy < ApplicationRecord
  belongs_to :house

  def self.daylight_energy_production
    pluck(:daylight, :energy_production).map{|daylight, energy_production|
      {
        x: daylight.to_f,
        y: energy_production,
      }
    }
  end

  def self.city_energy_production
    joins(:house).group('houses.city').sum('energies.energy_production')
  end
end
