require 'csv'

# citiesの取込
# rake db:seed_fu FILTER=cities

csv = CSV.read('db/fixtures/seeds/cities.csv', headers: true)

csv.each do |row|
  City.seed(:id) do |s|
    s.id = row[0]
    s.name = row[1]
  end
end
