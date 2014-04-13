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
  CSV.foreach("../../data/house_data.csv", :headers => true) do |row|
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
CSV.foreach("../../data/house_data.csv", :headers => true) do |row|
  House.create!(firstname:     row['Firstname'],
                lastname:      row['Lastname'],
                city:          cities[row['City']],
                num_of_people: row['num_of_people'],
                has_child:     row['has_child'] == 'Yes' ? 1 : 0,
                )
end

# Energy
# Read MIAC city codes from csv file
CSV.foreach("../../data/dataset_50.csv", :headers => true) do |row|
  Energy.create!(label:    row['Label'],
                 house_id: row['House'],
                 year:     row['Year'],
                 month:    row['Month'],
                 temperature:       row['Temperature'],
                 daylight:          row['Daylight'],
                 energy_production: row['EnergyProduction'],
                 )
end
