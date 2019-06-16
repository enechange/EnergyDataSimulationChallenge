require 'csv'

# energiesの取込
# rake db:seed_fu FILTER=energies

csv = CSV.read('db/fixtures/seeds/dataset_50.csv', headers: true)

csv.each do |row|
  Energy.seed(:id) do |s|
    s.id = row[0]
    s.label = row[1]
    s.house_id = row[2]
    s.year = row[3]
    s.month = row[4]
    s.temperature = row[5]
    s.daylight = row[6]
    s.energy_production = row[7]
  end
end
