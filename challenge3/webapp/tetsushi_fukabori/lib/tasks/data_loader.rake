namespace :data_loader do
  require 'csv'

  task load_house_data: :environment do
    houses = []
    CSV.foreach('db/input_data/house_data.csv', headers: true) do |row|
      houses << House.new(
        id: row['ID'].to_i,
        firstname: row['Firstname'],
        lastname: row['Lastname'],
        city: row['City'].downcase,
        num_of_people: row['num_of_people'].to_i,
        has_child: row['has_child'] == 'Yes',
      )
    end

    House.import! houses
  end

  task load_energy_data: :environment do
    energies = []
    CSV.foreach('db/input_data/dataset_50.csv', headers: true) do |row|
      energies << Energy.new(
        id: row['ID'].to_i,
        house_id: row['House'].to_i,
        label: row['Label'].to_i,
        year: row['Year'].to_i,
        month: row['Month'].to_i,
        temperature: row['Temperature'].to_f,
        daylight: row['Daylight'].to_f,
        production: row['EnergyProduction'].to_f,
      )
    end

    Energy.import! energies
  end
end
