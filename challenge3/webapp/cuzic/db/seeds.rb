# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

def data_filename basename
  Rails.root + "data/" + basename
end

def read_csv basename
  Enumerator.new do |y|
    filename = data_filename basename
    CSV.foreach(filename, :headers => true) do |row|
      y << row
    end
  end
end

def csvrow2dbrecord csvrow, mapping
  {}.tap do |h|
    mapping.each do |k, v|
      h[k] = csvrow[v]
    end
  end
end

def make_mapping str
  str.split("\n").map{|line| line.strip.split}
end

def create_houses
  mapping = make_mapping <<-EOD
  id            ID
  firstname     Firstname
  lastname      Lastname
  city          City
  num_of_people num_of_people
  has_child     has_child
  EOD
  read_csv("house_data.csv").each do |csvrow|
    record = csvrow2dbrecord csvrow, mapping
    record['has_child'] = record['has_child'] == 'Yes'
    House.create!(record)
  end
end

def create_energies
  mapping = make_mapping <<-EOD
  id                ID
  label             Label
  house_id          House
  year              Year
  month             Month
  temperature       Temperature
  daylight          Daylight
  energy_production EnergyProduction
  EOD
  read_csv("dataset_50.csv").each do |csvrow|
    record = csvrow2dbrecord csvrow, mapping
    Energy.create!(record)
  end
end

create_houses
create_energies
