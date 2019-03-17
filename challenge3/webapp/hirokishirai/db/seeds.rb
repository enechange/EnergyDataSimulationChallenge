# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# OPTIMIZE: 読み込むcsvが大きくなった時の負荷検証が必要

# Check existing data.
# ============================

target_models = [City, House, MonthlyHouseEnergyProduction]

if target_models.map(&:any?).include?(true)
  decision = nil
  while %w(Y n).exclude?(decision)
    print <<~ALERT.chomp
      ======================
      There are some data.
      Destroy data of #{target_models.map(&:name).join(', ')} and Continue?(Y/n):
    ALERT
    decision = STDIN.gets.chomp
  end
  if decision == 'n'
    puts 'Stopped.'
    exit 0
  else
    ActiveRecord::Base.transaction do
      target_models.each do |target_model|
        target_model.destroy_all
        ActiveRecord::Base.connection.execute "ALTER SEQUENCE #{target_model.table_name}_id_seq RESTART WITH 1"
      end
      puts 'Destroyed.'
    end
    puts 'Continue...'
  end
end

# Bulk import data.
# ============================

require 'csv'
require 'activerecord-import'
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

cities = {}
CSV.foreach('../../data/house_data.csv', :headers => true) do |row|
  cities[row['City']] ||= City.new(name: row['City'])
  cities[row['City']].houses.build(
    id: row['ID'].to_i,
    firstname:     row['Firstname'],
    lastname:      row['Lastname'],
    num_of_people: row['num_of_people'].to_i,
    has_child:     row['has_child'] == 'Yes',
  )
end
City.import cities.values, recursive: true

monthly_house_energy_productions = []
CSV.foreach('../../data/dataset_50.csv', :headers => true) do |row|
  monthly_house_energy_productions << MonthlyHouseEnergyProduction.new(
    id:                row['ID'].to_i,
    label:             row['Label'].to_i,
    house_id:          row['House'].to_i,
    year:              row['Year'].to_i,
    month:             row['Month'].to_i,
    temperature:       row['Temperature'].to_f,
    daylight:          row['Daylight'].to_f,
    energy_production: row['EnergyProduction'].to_i,
  )
end
MonthlyHouseEnergyProduction.import monthly_house_energy_productions
puts 'Done.'
