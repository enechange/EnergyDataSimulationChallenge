require 'csv'

house_csv = CSV.read("#{Rails.root.to_s}/tmp/house_data.csv", headers: true)
house_csv.map{|r|
  House.create(
    csv_house_id:  r['ID'].to_i,
    firstname:     r['Firstname'],
    lastname:      r['Lastname'],
    city:          r['City'],
    num_of_people: r['num_of_people'].to_i,
    has_child:     r['has_child'] == 'Yes')
}
