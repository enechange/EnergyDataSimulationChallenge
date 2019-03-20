# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

CSV.foreach('db/data/dataset_50.csv', headers: true) do |row|
  Energy.create(
      label:             row['Label'],
      house_id:          row['House'],
      year:              row['Year'],
      month:             row['Month'],
      temperature:       row['Temperature'],
      daylight:          row['Daylight'],
      energy_production: row['EnergyProduction']
  )
end

CSV.foreach('db/data/house_data.csv', headers: true) do |row|
  House.create(
      original_id:            row['Id'],
      firstname:     row['Firstname'],
      lastname:      row['Lastname'],
      city:          row['City'],
      num_of_people: row['num_of_people'],
      has_child:     row['has_child']
  )
end