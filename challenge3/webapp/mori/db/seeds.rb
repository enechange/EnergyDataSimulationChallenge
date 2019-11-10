require "csv"

CSV.foreach('db/house_data.csv', headers: true) do |row|
    House.create(
        firstname: row[1],
        lastname: row[2],
        city: row[3],
        num_of_people: row[4],
        has_child: row[5]
        )
end 

CSV.foreach('db/dataset_50.csv', headers: true) do |row|
    Dataset.create(
        label: row[1],
        house_id: row[2],
        year: row[3],
        month: row[4],
        temperature: row[5],
        daylight: row[6],
        energy_production: row[7]
        )
end
