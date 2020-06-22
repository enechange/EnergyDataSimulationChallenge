# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

now = Time.now

houses = []
CSV.foreach("../../data/house_data.csv", :headers => true) do |row|
  houses.push({
    id: row['ID'],
    first_name: row['Firstname'],
    last_name: row['Lastname'],
    city: row['City'],
    num_of_people: row['num_of_people'],
    has_child: row['has_child'],
    created_at: now,
    updated_at: now
  })
end
House.insert_all(houses)

energies = []
CSV.foreach("../../data/dataset_50.csv", :headers => true) do |row|
  p row
  energies.push({
    id: row['ID'],
    label: row['Label'],
    house_id: row['House'],
    year: row['Year'],
    month: row['Month'],
    temperature: row['Temperature'],
    daylight: row['Daylight'],
    energy_production: row['EnergyProduction'],
    created_at: now,
    updated_at: now
  })
end
Energy.insert_all(energies)
