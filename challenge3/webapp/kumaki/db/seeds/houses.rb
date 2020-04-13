require "csv"

CSV.foreach('db/seeds/csv/houses.csv', headers: true) do |row|
  house = House.create!(
    firstname: row['Firstname'],
    lastname: row['Lastname'],
    city_id: row['city_id'],
    num_of_people: row['num_of_people'], 
    has_child: row['has_child']
  )
  puts "#{house.firstname + " " + house.lastname}'s house has created!" if house
end