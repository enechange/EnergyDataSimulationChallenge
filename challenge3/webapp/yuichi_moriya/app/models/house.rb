class House < ApplicationRecord
  validates :firstname, presence: true, length: { maximum: 255 }
  validates :lastname, presence: true, length: { maximum: 255 }
  validates :cityname, presence: true, length: { maximum: 255 }
  validates :num_of_people, presence: true, numericality: true
  
  has_many :energies
  
  def self.monthly_energy_production_by_city
    House
      .joins(:energies)
      .select("
        houses.cityname cityname, 
        energies.year year,
        energies.month month,
        avg(energies.temperature) temperature,
        avg(energies.daylight) daylight,
        avg(energies.energy_production) energy_production
      ")
      .group('houses.cityname, energies.year, energies.month')
      .order('houses.cityname, energies.year, energies.month')
  end
  
  def self.monthly_energy_production_by_city_and_family_structure
    House
      .joins(:energies)
      .select("
        houses.cityname cityname, 
        houses.num_of_people num_of_people,
        houses.has_child has_child,
        energies.year year,
        energies.month month,
        avg(energies.energy_production) energy_production
      ")
      .group('houses.cityname, houses.num_of_people, houses.has_child, energies.year, energies.month')
      .order('houses.cityname, houses.num_of_people, houses.has_child, energies.year, energies.month')
  end
end
