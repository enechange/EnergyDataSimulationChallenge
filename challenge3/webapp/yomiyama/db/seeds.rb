require 'csv'

CSV.foreach('db/dataset_50.csv', headers: true) do |row|
  Dataset.create!(
    label: row[1],
    house: row[2],
    year: row[3],
    month: row[4],
    temperature: row[5],
    daylight: row[6],
    energyproduction: row[7]
  )
end

def convert_bool(string)
  case string
  when 'Yes'
    true
  when 'No'
    false
  end
end

CSV.foreach('db/house_data.csv', headers: true) do |row|
  HouseDatum.create!(
    firstname: row[1],
    lastname: row[2],
    city: row[3],
    num_of_people: row[4],
    has_child: convert_bool(row[5])
  )
end