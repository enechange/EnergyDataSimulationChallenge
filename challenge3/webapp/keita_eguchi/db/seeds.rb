require 'csv'

def to_boolean(string)
  case string
  when 'Yes'
    true
  when 'No'
    false
  end
end

CSV.foreach("db/house_data.csv", headers: true) do |row|
  House.create!(first_name:     row['Firstname'],
                last_name:      row['Lastname'],
                city:           row['City'],
                num_of_people:  row['num_of_people'],
                has_child:      to_boolean(row['has_child']),
                )
end

CSV.foreach("db/dataset_50.csv", headers: true) do |row|
  Energy.create!(label:             row['Label'],
                 house_id:          row['House'],
                 year:              row['Year'],
                 month:             row['Month'],
                 temperature:       row['Temperature'],
                 daylight:          row['Daylight'],
                 energy_production: row['EnergyProduction'],
                 )
end
