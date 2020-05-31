require "csv"

CSV.foreach('db/house_data.csv', headers: true) do |row|
  House.create(
    first_name: row['Firstname'],
    last_name: row['Lastname'],
    city: row['City'],
    num_of_people: row['num_of_people'],
    has_child: row['has_child'] == 'Yes' ? true : false,
                )
end

CSV.foreach('db/dataset_50.csv', headers: true) do |row|
  Energy.create(
    label: row['Label'],
    house_id: row['House'],
    temperature: row['Temperature'],
    daylight: row['Daylight'],
    energy_production: row['EnergyProduction'],
    year_month: row['Year'] + '/' + row['Month'],
                )
end
