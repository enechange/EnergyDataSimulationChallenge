require 'csv'
CSV.foreach('../../data/house_data.csv', headers: true) do |record|
  if record['has_child'] == "Yes"
    has_child_boolean = true
  else
    has_child_boolean = false
  end
  House.create(
    id: record['ID'],
    firstname: record['Firstname'],
    lastname: record['Lastname'],
    city: record['City'],
    num_of_people: record['num_of_people'],
    has_child: has_child_boolean
  )
end

CSV.foreach('../../data/dataset_50.csv', headers: true) do |record|
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
