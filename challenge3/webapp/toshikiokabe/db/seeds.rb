require 'csv'

CSV.foreach('db//house_data.csv', headers: true) do |row|
  h = House.find_or_initialize_by(id: row['ID'])
  h.update_attributes(
    firstname: row['Firstname'],
    lastname: row['Lastname'],
    city: row['City'],
    num_of_people: row['num_of_people'],
    has_child: row['has_child']
  )
end

CSV.foreach('db/dataset_50.csv', headers: true) do |row|
  e = Energy.find_or_initialize_by(id: row['ID'])
  e.update_attributes(
    label: row['Label'],
    house_id: row['House'],
    year: row['Year'],
    month: row['Month'],
    temperature: row['Temperature'],
    daylight: row['Daylight'],
    energy_production: row['EnergyProduction']
  )
end
