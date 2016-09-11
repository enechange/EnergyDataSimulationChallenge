require 'csv'
namespace :csv_data do
  desc 'import houses data from csv file'
  task :import_house_data => :environment do

    FILE_PATH = '../../data/house_data.csv'.freeze
    COLUMN_HAS_CHILD_YES = 'Yes'.freeze

    csv_table  = CSV.table(FILE_PATH)

    # create city records
    csv_table.each do |row|
      City.where(name: row[:city]).first_or_create
    end

    # create house reords
    csv_table.each do |row|
      city = City.find_by(name: row[:city])
      city.houses.where(first_name:    row[:firstname],
                         last_name:     row[:lastname],
                         num_of_people: row[:num_of_people],
                         has_child:     (row[:has_child] == COLUMN_HAS_CHILD_YES)
      ).first_or_create
    end
  end

  desc 'import energies data from csv file'
  task :import_energy_data => :environment do
    FILE_PATH = '../../data/dataset_50.csv'
    
    csv_table = CSV.table(FILE_PATH)

    # craete energy records
    csv_table.each do |row|
      house = House.find(row[:house])
      house.energies.where(label: row[:label],
                          record_at: Date.civil(row[:year], row[:month], -1),
                          temperature: row[:temperature],
                          daylight: row[:daylight],
                          energy_production: row[:energyproduction]
      ).first_or_create
    end
  end
end