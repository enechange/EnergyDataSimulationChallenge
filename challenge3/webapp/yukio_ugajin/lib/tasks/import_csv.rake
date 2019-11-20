def convert_to_int(city)
  if city == 'Cambridge'
    0
  elsif city == 'London'
    1
  elsif city == 'Oxford'
    2
  end
end

namespace :import_csv do
  require 'csv'

  task houses: :environment do
    houses = []
    path = '../../data/house_data.csv'

    CSV.foreach(path, headers: true) do |row|
      houses << House.new(
        firstname:     row['Firstname'],
        lastname:      row['Lastname'],
        city:          convert_to_int(row['City']),
        num_of_people: row['num_of_people'].to_i,
        has_child:     row['has_child'] == 'Yes'
      )
    end
    House.import houses
  end

  task energy_details: :environment do
    energy_details = []
    path = '../../data/dataset_50.csv'

    CSV.foreach(path, headers: true) do |row|
      energy_details << EnergyDetail.new(
        label:             row['Label'].to_i,
        house_id:          row['House'].to_i,
        year:              row['Year'].to_i,
        month:             row['Month'].to_i,
        temperature:       row['Temperature'].to_f,
        daylight:          row['Daylight'].to_f,
        energy_production: row['EnergyProduction'].to_i
      )
    end
    EnergyDetail.import energy_details
  end
end