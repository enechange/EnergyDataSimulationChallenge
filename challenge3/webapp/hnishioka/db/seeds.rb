HouseEnergyUsage.delete_all
EnergyProduction.delete_all

CsvImportService.call(HouseEnergyUsage, 'db/house_data.csv')
CsvImportService.call(EnergyProduction, 'db/dataset_50.csv')
