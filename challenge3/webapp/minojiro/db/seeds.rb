require 'csv'

house_csv = CSV.read("#{Rails.root.to_s}/data/house_data.csv", headers: true)
energy_csv = CSV.read("#{Rails.root.to_s}/data/dataset_50.csv", headers: true)

ActiveRecord::Base.transaction do
  House.import(house_csv.map{|r|
    House.new(
      csv_house_id:  r['ID'].to_i,
      firstname:     r['Firstname'],
      lastname:      r['Lastname'],
      city:          r['City'],
      num_of_people: r['num_of_people'].to_i,
      has_child:     r['has_child'] == 'Yes')
  })

  Energy.import(energy_csv.map{|r|
    Energy.new(
      csv_energy_id:     r['ID'],
      label:             r['Label'],
      year:              r['Year'],
      month:             r['Month'],
      temperature:       r['Temperature'],
      daylight:          r['Daylight'],
      energy_production: r['EnergyProduction'],
      house:             House.find_by(csv_house_id: r['House']))
  })
end
