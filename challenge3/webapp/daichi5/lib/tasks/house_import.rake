require 'csv'

namespace :import do
  desc "Import House Data from csv"

  task houses: :environment do
    path = File.join Rails.root, "db/data/house_data.csv"
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
        id: row["ID"],
        first_name: row["Firstname"],
        last_name: row["Lastname"],
        city: row["City"],
        num_of_people: row["num_of_people"],
        has_child: row["has_child"]
      }
    end
    puts "start to create houses data"
    begin
      House.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end

  end
end
