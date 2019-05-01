puts "* --------------------------------------------------"
puts "* Loading: db/seeds/02_energies.rb"
puts "* --------------------------------------------------"

require 'csv'
maxid = 0

CSV.foreach("../../data/dataset_50.csv", :headers => true) do |row|
  Energy.create!(
    id:                 (id = row['ID'].to_i),
    label:              row['Label'],
    house_id:           row['House'],
    year:               row['Year'],
    month:              row['Month'],
    year_month:         format("%d%02d", row['Year'], row['Month']),
    temperature:        row['Temperature'],
    daylight:           row['Daylight'],
    energy_production:  row['EnergyProduction']
  )
  maxid = id if (maxid < id)
end

# update sequence
ActiveRecord::Base.connection.execute("ALTER SEQUENCE energies_id_seq RESTART WITH #{(maxid + 1)}")
