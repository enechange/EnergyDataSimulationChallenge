# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

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

CSV.foreach("../../data/house_data.csv", :headers => true) do |row|
  House.create!(firstname:     row['Firstname'],
                lastname:      row['Lastname'],
                city:          row['City'],
                num_of_people: row['num_of_people'],
                has_child:     row['has_child'],
                )
end
