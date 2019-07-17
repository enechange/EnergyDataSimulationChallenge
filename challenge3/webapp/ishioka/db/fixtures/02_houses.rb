require 'csv'

# housesの取込
# rake db:seed_fu FILTER=houses

csv = CSV.read('db/fixtures/seeds/house_data.csv', headers: true)

csv.each do |row|
  House.seed(:id) do |s|
    s.id = row[0]
    s.first_name = row[1]
    s.last_name = row[2]
    s.city_id = City.find_by!(name: row[3]).id
    s.num_of_people = row[4]
    s.has_child = row[5] ==  'Yes'
  end
end
