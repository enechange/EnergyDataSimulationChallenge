require 'csv'

csv = CSV.read('db/fixtures/house_data.csv')

csv.each_with_index do |house, i|
  # 見出し行をスキップ
  next if i == 0

  House.seed do |s|
    s.id = house[0]
    s.first_name = house[1]
    s.last_name = house[2]
    s.city = house[3]
    s.num_of_people = house[4]
    s.has_child = if house[5] == 'Yes'
                    true
                  elsif house[5] == 'No'
                    false
                  else
                    raise 'has_childに不正な値が入力されています'
                  end
  end
end

