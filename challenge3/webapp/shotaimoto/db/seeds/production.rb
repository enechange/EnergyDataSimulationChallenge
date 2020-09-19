require 'csv'
CSV.foreach('db/house_data.csv', headers: true) do |record|
if City.exists?(name: record['City'])
  city = City.find_by(name: record['City'])
else
  city = City.create(
    name: record['City']
  )
end

  if record['has_child'] == "Yes"
    has_child_boolean = true
  else
    has_child_boolean = false
  end
  House.create(
    id: record['ID'],
    firstname: record['Firstname'],
    lastname: record['Lastname'],
    city_id: city.id,
    num_of_people: record['num_of_people'],
    has_child: has_child_boolean
  )
end

CSV.foreach('db/dataset_50.csv', headers: true) do |record|
  Energy.create(
    label: record['Label'],
    house_id: record['House'],
    year: record['Year'],
    month: record['Month'],
    temperature: record['Temperature'],
    daylight: record['Daylight'],
    energy_production: record['EnergyProduction']
  )
end
