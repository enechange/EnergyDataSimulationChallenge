puts "* --------------------------------------------------"
puts "* Loading: db/seeds/01_houses.rb"
puts "* --------------------------------------------------"

require 'csv'
maxid = 0

CSV.foreach("../../data/house_data.csv", :headers => true) do |row|
  House.create!(
    id:             (id = row['ID'].to_i),
    firstname:      row['Firstname'],
    lastname:       row['Lastname'],
    city:           City.id(row['City']),
    num_of_people:  row['num_of_people'],
    has_child:      (row['has_child'] === 'Yes')
  )
  maxid = id if (maxid < id)
end

# update sequence
ActiveRecord::Base.connection.execute("ALTER SEQUENCE houses_id_seq RESTART WITH #{(maxid + 1)}")
