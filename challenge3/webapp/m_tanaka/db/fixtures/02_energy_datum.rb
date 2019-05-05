require 'csv'

csv = CSV.read('db/fixtures/dataset_50.csv')

csv.each_with_index do |energy, i|
  next if i == 0

  EnergyDatum.seed do |s|
    s.id = energy[0]
    s.label = energy[1]
    s.house_id = energy[2]
    s.year = energy[3]
    s.month = energy[4]
    s.temperature = energy[5]
    s.daylight = energy[6]
    s.energy_production = energy[7]
  end
end


