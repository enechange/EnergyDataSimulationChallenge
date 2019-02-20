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

energy_csv = CSV.read("#{Rails.root.to_s}/tmp/dataset_50.csv", headers: true)
energy_csv.map{|r|
  Energy.create(
    csv_energy_id:     r['ID'],
    label:             r['Label'],
    year:              r['Year'],
    month:             r['Month'],
    temperature:       r['Temperature'],
    daylight:          r['Daylight'],
    energy_production: r['EnergyProduction'],
    house:             House.find_by(csv_house_id: r['House']))
}
