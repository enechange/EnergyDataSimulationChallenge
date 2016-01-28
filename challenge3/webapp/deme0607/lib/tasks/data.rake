require 'csv'

namespace :data do
  DATA_DIR = File.expand_path('../../data', Rails.root).freeze

  desc 'import house data from csv file'
  task :import_house => :environment do
    HOUSE_DATA_PATH = File.join(DATA_DIR, 'house_data.csv').freeze
    CSV_LABEL_YES   = 'Yes'.freeze

    records = CSV.table(HOUSE_DATA_PATH)

    records.each do |record|
      city  = City.find_or_create_by(name: record[:city])
      house = House.find_or_initialize_by(id: record[:id])

      house.update_attributes(
        first_name:    record[:firstname],
        last_name:     record[:lastname],
        city:          city,
        num_of_people: record[:num_of_people],
        has_child:     record[:has_child] == CSV_LABEL_YES,
      )
    end
  end

  desc 'import eneregy data from csv file'
  task :import_energy => :environment do
    ENERGY_DATA_PATH = File.join(DATA_DIR, 'dataset_50.csv').freeze

    records = CSV.table(ENERGY_DATA_PATH)

    records.each do |record|
      energy = Energy.find_or_initialize_by(id: record[:id])
      house  = House.find(record[:house])

      energy.update_attributes(
        house:             house,
        label:             record[:label],
        temperature:       record[:temperature],
        daylight:          record[:daylight],
        energy_production: record[:energyproduction],
        recorded_at:       Date.new(record[:year], record[:month]),
      )
    end
  end
end
