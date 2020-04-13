require "csv"

CSV.foreach('db/seeds/csv/cities.csv', headers: true) do |row|
  city = City.create!(
    name: row['name']
  )
  puts "#{city.name} has created!" if city
end