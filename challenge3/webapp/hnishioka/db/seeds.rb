HouseEnergyUsage.delete_all
EnergyProduction.delete_all

HouseEnergyUsage.import('db/house_data.csv')
puts 'Imported house_data.csv'

EnergyProduction.import('db/dataset_50.csv')
puts 'Imported dataset_50.csv'
