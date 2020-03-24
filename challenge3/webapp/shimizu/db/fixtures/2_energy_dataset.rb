# house.rb => energy_dataset.rb の順で作成させるためファイル名に番号記載
require 'csv'

csv = CSV.read('db/fixtures/data/dataset_50.csv', headers: true)

csv.each do |energy|
  EnergyDataset.seed do |s|
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
