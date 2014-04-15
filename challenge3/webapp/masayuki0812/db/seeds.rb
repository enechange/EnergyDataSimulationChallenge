# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require 'set'

def get_cities()
  cities = Set[]
  CSV.foreach("../data/house_data.csv", :headers => true) do |row|
    cities.add(row['City'])
  end
  cities.to_a().sort()
end

# City
cities = {}
for city in get_cities() do
  cities[city] = City.create!(name: city,
                              )
end

# House
city_of_houses = {}
CSV.foreach("../data/house_data.csv", :headers => true) do |row|
  house = House.create!(firstname:     row['Firstname'],
                lastname:      row['Lastname'],
                city_id:       cities[row['City']].id,
                num_of_people: row['num_of_people'],
                has_child:     row['has_child'] == 'Yes' ? 1 : 0,
                )
  city_of_houses[house.id] = cities[row['City']]
end

# Energy
# Read MIAC city codes from csv file
energy_of_cities = {}
CSV.foreach("../data/dataset_50.csv", :headers => true) do |row|

  house_id = row['House'].to_i
  city_id = city_of_houses[house_id].id
  year = row['Year']
  month = row['Month']

  Energy.create!(label:    row['Label'],
                 house_id: house_id,
                 year:     year,
                 month:    month,
                 temperature:       row['Temperature'],
                 daylight:          row['Daylight'],
                 energy_production: row['EnergyProduction'],
                 )
  # Sum up energy of cities
  if not energy_of_cities.has_key?(city_id)
    energy_of_cities[city_id] = {}
  end
  if not energy_of_cities[city_id].has_key?(year)
    energy_of_cities[city_id][year] = {}
  end
  if not energy_of_cities[city_id][year].has_key?(month)
    energy_of_cities[city_id][year][month] = 0
  end
  energy_of_cities[city_id][year][month] += row['EnergyProduction'].to_i
end

# City Energy
energy_of_cities.each_key { |city_id|
  energy_of_cities[city_id].each_key { |year|
    energy_of_cities[city_id][year].each { |month, value|
      CityEnergy.create!(city_id: city_id,
                         year:    year,
                         month:   month,
                         energy_production: value,
                         )
    }
  }
}
