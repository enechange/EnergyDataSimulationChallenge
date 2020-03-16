require 'csv'

house_csv = CSV.read('db/data/house_data.csv', headers: true)
energy_dataset_csv = CSV.read('db/data/dataset_50.csv', headers: true)

ActiveRecord::Base.transaction do
  House.import(house_csv.map{|k|
    House.new(
      house_ID:      k['ID'],
      first_name:    k['Firstname'],
      last_name:     k['Lastname'],
      city:          k['City'],
      num_of_people: k['num_of_people'],
      has_child:     k['has_child'] == 'Yes')
  })

  EnergyDataset.import(energy_dataset_csv.map{|k|
    EnergyDataset.new(
      energy_ID:         k['ID'],
      label:             k['Label'],
      house_id:          House.find_by(house_ID: r['House']),
      year:              k['Year'],
      month:             k['Month'],
      temperature:       k['Temperature'],
      daylight:          k['Daylight'],
      energy_production: k['EnergyProduction'])
  })
end
