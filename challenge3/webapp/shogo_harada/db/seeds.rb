require "csv"

CSV.foreach("db/data/house_data.csv", :headers => true) do |row|
  House.create(firstname:     row['Firstname'],
               lastname:      row['Lastname'],
               city:          row['City'],
               num_of_people: row['num_of_people'],
               has_child:     row['has_child'] == 'Yes' ? true : false,
               )
end

CSV.foreach("db/data/dataset_50.csv", :headers => true) do |row|
  EnergyUsage.create!(label:             row['Label'],
                      house_id:          row['House'],
                      year:              row['Year'],
                      month:             row['Month'],
                      temperature:       row['Temperature'],
                      daylight:          row['Daylight'],
                      energyproduction:  row['EnergyProduction'],
                      )
end
