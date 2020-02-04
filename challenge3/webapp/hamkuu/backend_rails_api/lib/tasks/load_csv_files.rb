require 'csv'

# Loads HouseOwner, and House model records
# from house_data.csv
def csv_load_houses_and_owners
  unless HouseOwner.count.zero? && House.count.zero?
    puts 'HouseOwner or Owner Model already has record(s).'

    return
  end

  CSV.foreach(Rails.root.join('lib/csv_files/house_data.csv'), headers: true) do |row|
    owner = HouseOwner.create({
      first_name: row['Firstname'],
      last_name: row['Lastname']
    })

    owner.houses.create({
      residents_count: row['num_of_people'],
      has_children: row['has_child'] == 'Yes',
      city: row['City']
    })
  end
end

# Loads HouseholdEnergyRecord model records
# from dataset_50.csv
def csv_load_house_energy_records
  unless HouseholdEnergyRecord.count.zero?
    puts 'HouseholdEnergyRecord Model already has record(s).'

    return
  end

  CSV.foreach(Rails.root.join('lib/csv_files/dataset_50.csv'), headers: true) do |row|
    HouseholdEnergyRecord.create({
      house_id: row['House'],
      record_date: Date.new(row['Year'].to_i, row['Month'].to_i, 1),
      temperature: row['Temperature'],
      daylight: row['Daylight'],
      energy_production: row['EnergyProduction'],
    })
  end
end

# Starts this script
csv_load_houses_and_owners
csv_load_house_energy_records
