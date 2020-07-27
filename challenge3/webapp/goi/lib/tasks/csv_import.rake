require 'csv'

namespace :csv_import do
  desc 'house_data.csv'
  task houses: :environment do
    make_house_data
  end

  desc 'dataset_50.csv'
  task energies: :environment do
    make_energy_data
  end
end


def make_house_data
  file_name = 'house_data.csv'
  file_import(file_name: file_name, title: 'house')
end

def make_energy_data
  file_name = 'dataset_50.csv'
  file_import(file_name: file_name,  title: 'energy')
end


def file_import(file_name: nil, title: nil)
  raise ArgumentError if file_name.nil? || title.nil?

  # path = File.join Rails.root, "db/csv/#{file_name}"
  path = File.join Rails.root, "lib/tasks/#{file_name}"
  puts "-- File Path: #{path}"

  import_data = eval("#{title}_csv_import(path: '#{path}')")
  puts '-- csv import start'

  begin
    if title == 'house'
      House.create!(import_data)
    elsif title == 'energy'
      Energy.create!(import_data)
    else
      raise
    end
    puts '-- import completed'
  rescue ArgumentError => e
    puts "-- raised error : unKnown argument #{e} "
  rescue ActiveModel::UnknownAttributeError => e
    puts '-- raised error : unKnown attribute '
  rescue => e
    puts "-- raised error : #{e} "
  end
end


def house_csv_import(path:)
  lists = []
  CSV.foreach(path, headers: true) do |row|
    lists << {
      id: row['ID'],
      first_name: row['Firstname'],
      last_name: row['Lastname'],
      city: row['City'],
      num_of_people: row['num_of_people'],
      has_child: (row['has_child'] == "Yes" ? true : false)
    }
  end

  lists
end

def energy_csv_import(path:)
  lists = []
  CSV.foreach(path, headers: true) do |row|
    lists << {
      id: row['ID'],
      label: row['Label'],
      house_id: row['House'],
      year: row['Year'],
      month: row['Month'],
      temperature: row['Temperature'],
      daylight: row['Daylight'],
      energy_production: row['EnergyProduction']
    }
  end

  lists
end
