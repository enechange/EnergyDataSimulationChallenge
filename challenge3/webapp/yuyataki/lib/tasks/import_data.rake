namespace :import_data do
  require "csv"
  desc "import dataset_50.csv"

  task dataset_50: :environment do
    puts "STARTED: Import dataset_50.csv (#{Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')})"
    csv_data = CSV.read("../../data/dataset_50.csv", headers: true)
    energies = csv_data.map do |data|
      Energy.new(
        id: data["ID"], label: data["Label"], house_id: data["House"],
        year: data["Year"], month: data["Month"],
        temperature: data["Temperature"], daylight: data["Daylight"],
        energy_production: data["EnergyProduction"]
      )
    end
    Energy.import(energies)
    puts "FINISHED: Import dataset_50.csv (#{Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')})"
  end

  desc "import house_data.csv"

  task house_data: :environment do
    puts "STARTED: Import house_data.csv (#{Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')})"
    csv_data = CSV.read("../../data/house_data.csv", headers: true)
    houses = csv_data.map do |data|
      House.new(
        id: data["ID"], firstname: data["Firstname"], lastname: data["Lastname"],
        city: data["City"], num_of_people: data["num_of_people"],
        has_child: data["has_child"] == "YES" ? true : false
      )
    end
    House.import(houses)
    puts "FINISHED: Import house_data.csv (#{Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')})"
  end
end
