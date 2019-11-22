class EnergyDetail < ApplicationRecord
  def scatter_position
    { x: daylight, y: energy_production }
  end
end
