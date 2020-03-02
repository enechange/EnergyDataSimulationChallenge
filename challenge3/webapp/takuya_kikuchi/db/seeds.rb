# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }

filepath    = 'data/house_data.csv'
puts 'Creating house data...'
CSV.foreach(filepath, csv_options) do |row|
  House.create!(
    first_name: row["Firstname"],
    last_name: row["Lastname"],
    city: row["City"],
    num_of_people: row["num_of_people"].to_i,
    has_child: row["has_child"] == "Yes"
  )
end

filepath    = 'data/dataset_50.csv'
puts 'Creating datasets...'
CSV.foreach(filepath, csv_options) do |row|
  Dataset.create!(
    label: row["Label"].to_i,
    house_id: row["House"].to_i,
    year: row["Year"].to_i,
    month: row["Month"].to_i,
    temperature: row["Temperature"].to_f,
    daylight: row["Daylight"].to_f,
    energy_production: row["EnergyProduction"].to_i
  )
end