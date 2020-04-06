require "csv"
provisional_day = "01"

CSV.foreach('db/seeds/csv/datasets.csv', headers: true) do |row|
  dataset = Dataset.create!(
    label: row['Label'],
    year_month: "#{row['Year']}-#{row['Month']}-#{provisional_day}",
    temperature: row['Temperature'],
    daylight: row['Daylight'],
    energy_production: row['EnergyProduction'],
    house_id: row['house_id']
  )
  puts "dataset of house_id: #{dataset.house_id}, label: #{dataset.label} has created!" if dataset
end
