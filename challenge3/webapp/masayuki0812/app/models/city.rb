class City < ActiveRecord::Base
  has_many :houses
  has_many :city_energies

  attr_accessor :count_house, :total_energy_production

  def self.all(with_count_house=false, with_total_energy_production=false)
    cities = super()
    count_of_cities = with_count_house ? House.count_by_city_id() : nil
    total_energy_production_of_cities = with_total_energy_production ? CityEnergy.sum_by_city_id() : nil
    cities.collect! { |city|
      if count_of_cities and count_of_cities.has_key?(city.id)
        city.count_house = count_of_cities[city.id.to_i]
      end
      if total_energy_production_of_cities and total_energy_production_of_cities.has_key?(city.id)
        city.total_energy_production = total_energy_production_of_cities[city.id.to_i]
      end
      city
    }
    cities
  end

  def self.find(id, with_count_house=false, with_total_energy_production=false)
    city = super(id)
    if with_count_house
      city.count_house = House.count_by_city_id(id)
    end
    if with_total_energy_production
      city.total_energy_production = CityEnergy.sum_by_city_id(id)
    end
    city
  end

  def self.energies(id=nil)
    if id
      city = find(id)
      data = city ? city.city_energies.map{|e| ["#{e.year}-#{e.month}", e.energy_production]} : []
      {
        data: [["date", "Energy Production"]] + data,
      }
    else
      cities = all().order("id")
      data = CityEnergy.all().order("city_id, year, month")

      data_by_date = {}
      data.each { |d|
        key = "%d-%02d" % [d.year, d.month]
        if not data_by_date.has_key?(key)
          data_by_date[key] = []
        end
        data_by_date[key] += [d.energy_production]
      }

      header = ['date'] + cities.map { |city|
        city.name
      }
      data = data_by_date.keys.sort.map { |key|
        [key] + data_by_date[key]
      }

      {
        data: [header] + data,
      }
    end
  end

end
