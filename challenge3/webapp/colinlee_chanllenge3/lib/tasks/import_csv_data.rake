# frozen_string_literal: true

require 'csv'

namespace :import_csv_data do
  HOUSE_FILE = 'house_data.csv'
  ENERGY_CONSUME_FILE = 'dataset_50.csv'

  desc 'Import house data from csv file to DB'
  task import_house_data_from_csv: :environment do
    read_csv_file(file_path(HOUSE_FILE)) do |row|
      item_attirbutes = {
        first_name: row['Firstname'].to_s,
        last_name: row['Lastname'].to_s,
        city: row['City'].to_s,
        living_count: row['num_of_people'].to_i,
        has_child: (row['has_child'].to_s == 'Yes') ? true : false,
      }
      house = House.new
      house.assign_attributes(item_attirbutes)
      house.save
    end
  end

  desc 'Import energy consume data from csv file to DB'
  task import_energy_consume_data_from_csv: :environment do
    read_csv_file(file_path(ENERGY_CONSUME_FILE)) do |row|
      item_attirbutes = {
        label: row['Label'].to_i,
        house_id: row['House'].to_i,
        year: row['Year'].to_i,
        month: row['Month'].to_i,
        temperature: row['Temperature'].to_f,
        daylight: row['Daylight'].to_f,
        energy_production: row['EnergyProduction'].to_i,
      }
      energy_consume = EnergyConsume.new
      energy_consume.assign_attributes(item_attirbutes)
      energy_consume.save
    end
  end

  private

  # Get the file path based on file name
  #
  # @params file_name [String] file name
  #
  # @return [String] the path of the file
  def file_path(file_name)
    File.join(Rails.root, 'public', 'csv_data', file_name)
  end

  # Read the csv data from file path
  #
  # @params file_path [String] file path
  # @yieldparam [Hash] csv row hash which will be yielded
  def read_csv_file(file_path, &block)
    if File.exist?(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        block.call(row)
      end
    end
  end
end
