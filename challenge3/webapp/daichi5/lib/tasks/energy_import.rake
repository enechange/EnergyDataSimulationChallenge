require 'csv'

namespace :import do
  desc "Import Energy Data from csv"

  task energies: :environment do
    path = File.join Rails.root, "db/data/dataset_50.csv"
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
        id: row["ID"],
        label: row["Label"],
        house_id: row["House"],
        year: row["Year"],
        month: row["Month"],
        temperature: row["Temperature"],
        daylight: row["Daylight"],
        energyproduction: row["EnergyProduction"]
      }
    end
    puts "start to create users data"
    begin
      Energy.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end

  end
end
