# house.rb => energy_dataset.rb の順で作成させるためファイル名に番号記載
require 'csv'

csv = CSV.read('db/fixtures/data/house_data.csv', headers: true)

csv.each do |house|
  House.seed do |s|
    s.id = house[0]
    s.first_name = house[1]
    s.last_name = house[2]
    s.city = house[3]
    s.num_of_people = house[4]
    s.has_child =
      if house[5] == 'Yes'
        true
      else
        false
      end
  end
end
