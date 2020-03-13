
require 'csv'

cities = Set[]
CSV.foreach('seeds/house_data.csv', headers: true) do |row|
  cities << row['City']
  cities.to_a().sort()
end

all_cities = {}
for city in cities do
  all_cities[city] = City.create(
    name: city
    )
end

i = 1
CSV.foreach("seeds/house_data.csv", headers: true) do |row|
  User.create!(firstname:                   row['Firstname'],
                lastname:                   row['Lastname'],
                city_id:                    all_cities[row['City']].id,
                num_of_people:              row['num_of_people'],
                has_child:                  row['has_child'],
                email:                      "#{i}@example.com",
                password:                   "1111aaaa",
                password_confirmation:      "1111aaaa"
                )
  i +=1
end


CSV.foreach("seeds/dataset_50.csv", headers: true) do |row|
  Energy.create!(user_id:          row['House'],
                 year:              row['Year'],
                 month:             row['Month'],
                 temperature:       row['Temperature'],
                 daylight:          row['Daylight'],
                 energy_production: row['EnergyProduction'],
                 )
end