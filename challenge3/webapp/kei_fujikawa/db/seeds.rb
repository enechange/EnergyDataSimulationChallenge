require 'csv'

def convert_to_boolean(string)
  case string
  when 'Yes'
    true
  when 'No'
    false
  end
end

Dataset.transaction do
  data = []
  CSV.foreach('db/dataset_50.csv', headers: true) do |row|
    data << Dataset.new(
                        label: row[1],
                        house: row[2],
                        year: row[3],
                        month: row[4],
                        temperature: row[5],
                        daylight: row[6],
                        energyproduction: row[7]
                        )
  end
  Dataset.import(data)
end

HouseDatum.transaction do
  data = []
  CSV.foreach('db/house_data.csv', headers: true) do |row|
    data << HouseDatum.new(
                           firstname: row[1],
                           lastname: row[2],
                           city: row[3],
                           num_of_people: row[4],
                           has_child: convert_to_boolean(row[5])
                           )
  end
  HouseDatum.import(data)
end
