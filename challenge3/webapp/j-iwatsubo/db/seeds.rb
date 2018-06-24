# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

require "csv"

# file path
csv_energy_path = "#{Rails.root}/db/csv/dataset_50.csv"
csv_house_path  = "#{Rails.root}/db/csv/house_data.csv"

# read CSV file
data_house  = CSV.read(csv_house_path, headers: true)
data_energy = CSV.read(csv_energy_path, headers: true)

# append seed data to DB
data_house.each do |data|
  House.create(
    :first_name     => data["Firstname"],
    :last_name      => data["Lastname"],
    :city           => data["City"],
    :num_of_people  => data["num_of_people"].to_i,
    :has_child      => data["has_child"]
  )
end

data_energy.each do |data|
  EnergyProduction.create(
    :label             => data["Label"].to_i,
    :house_id          => data["House"].to_i,
    :year              => data["Year"].to_i,
    :month             => data["Month"].to_i,
    :temperature       => data["Temperature"].to_f,
    :daylight          => data["Daylight"].to_f,
    :energy_production => data["EnergyProduction"].to_f
  )
end


