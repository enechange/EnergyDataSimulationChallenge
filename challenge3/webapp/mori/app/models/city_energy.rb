class CityEnergy < ApplicationRecord
  belongs_to :city
  
  def self.sum_city_energy(id)
    @sum = group('city_id').sum('energy_production')
    @sum[id]
  end
  
  def self.sum_cities_energy()
    @sum = group('city_id').sum('energy_production')
  end
end
