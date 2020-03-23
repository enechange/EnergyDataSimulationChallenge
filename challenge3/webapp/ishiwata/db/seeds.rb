# frozen_string_literal: true

require 'csv'

CSV.foreach('db/dataset_50.csv', headers: true) do |row|
  Energy.create!(label: row['Label'],
                 house_id: row['House'],
                 year: row['Year'],
                 month: row['Month'],
                 temperature: row['Temperature'],
                 daylight: row['Daylight'],
                 energy_production: row['EnergyProduction'])
end

CSV.foreach('db/house_data.csv', headers: true) do |row|
  House.create!(firstname: row['Firstname'],
                lastname: row['Lastname'],
                city: row['City'],
                num_of_people: row['num_of_people'],
                has_child: row['has_child'])
end
