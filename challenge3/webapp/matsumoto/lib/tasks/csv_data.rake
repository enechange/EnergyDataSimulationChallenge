require 'csv'
namespace :csv_data do

  HOUSE_DATA_PATH      = './data/house_data.csv'.freeze
  ENERGY_DATA_PATH     = './data/dataset_50.csv'.freeze
  COLUMN_HAS_CHILD_YES = 'Yes'.freeze

  task :import_data => :environment do
    initialize_table
    import_house_data
    import_energy_data
  end

  def initialize_table
    Energy.destroy_all
    House.destroy_all
    City.destroy_all
    ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 0")
    ActiveRecord::Base.connection.execute("TRUNCATE ENERGIES")
    ActiveRecord::Base.connection.execute("TRUNCATE CITIES")
    ActiveRecord::Base.connection.execute("TRUNCATE HOUSES")
    ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 1")
  end

  def import_house_data
    csv_table = CSV.table(HOUSE_DATA_PATH)

    # create city records
    csv_table.each do |row|
      City.where(name: row[:city]).first_or_create
    end

    # create house records
    csv_table.each do |row|
      city = City.find_by(name: row[:city])
      city.houses.create(first_name:    row[:firstname],
                         last_name:     row[:lastname],
                         num_of_people: row[:num_of_people],
                         has_child:     (row[:has_child] == COLUMN_HAS_CHILD_YES)
      )
    end
  end

  def import_energy_data
    csv_table = CSV.table(ENERGY_DATA_PATH)
    # create energy records
    csv_table.each do |row|
      house = House.find(row[:house])
      house.energies.create(label:             row[:label],
                            record_at:         Date.civil(row[:year], row[:month], -1),
                            temperature:       row[:temperature],
                            daylight:          row[:daylight],
                            energy_production: row[:energyproduction]
      )
    end
  end
end