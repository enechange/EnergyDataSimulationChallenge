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
      elsif
        city.count_house = 0
      end
      if total_energy_production_of_cities and total_energy_production_of_cities.has_key?(city.id)
        city.total_energy_production = total_energy_production_of_cities[city.id.to_i]
      elsif
        city.total_energy_production = 0
      end
      city
    }
    cities
  end

  def self.find(id, with_count_house=false, with_total_energy_production=false)
    city = super(id)
    if with_count_house
      city.count_house = House.count_by_city_id(id)
      if not city.count_house
        city.count_house = 0
      end
    end
    if with_total_energy_production
      city.total_energy_production = CityEnergy.sum_by_city_id(id)
      if not city.total_energy_production
        city.total_energy_production = 0
      end
    end
    city
  end

  def self.energies(id=nil)
    # TODO: This range should be given
    # generate row keys explicitly to allow gap of data
    target_dates = []
    for y in [2011, 2012, 2013]
      for m in [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        next if (y == 2011 and m < 7) or (y == 2013 and 6 < m)
        target_dates += ["%d-%02d" % [y, m]]
      end
    end

    if id
      city = find(id)

      # reconstruct guery result for easy result generation
      data_by_date = {}
      if city
        city.city_energies.each { |d|
          key = "%d-%02d" % [d.year, d.month]
          data_by_date[key] = d.energy_production
        }
      end

      # generate result rows
      rows = [['date', "Energy Production"]]
      target_dates.each { |target_date|
        row = [target_date]
        p target_date, data_by_date.has_key?(target_date)
        if data_by_date.has_key?(target_date)
          row += [data_by_date[target_date]]
        elsif
          row += [0]
        end
        rows += [row]
      }
    else
      cities = all().order("id")
      data = CityEnergy.all().order("city_id, year, month")

      # reconstruct guery result for easy result generation
      data_by_date = {}
      data.each { |d|
        key = "%d-%02d" % [d.year, d.month]
        if not data_by_date.has_key?(key)
          data_by_date[key] = {}
        end
        data_by_date[key][d.city_id] = d.energy_production
      }

      # generate result rows
      rows = [['date'] + cities.map{ |city| city.name }]
      target_dates.each { |target_date|
        row = [target_date]
        if data_by_date.has_key?(target_date)
          d = data_by_date[target_date]
          cities.each { |city|
            row += [d.has_key?(city.id) ? d[city.id] : 0]
          }
        elsif
          row += Array.new(cities.length, 0)
        end
        rows += [row]
      }
    end

    {
      data: rows
    }
  end

end
