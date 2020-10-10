# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

house_data = CSV.read('db/house_data.csv', headers: true)
dataset = CSV.read('db/dataset_50.csv', headers: true)

ActiveRecord::Base.transaction do
  HouseDataService.call(house_data)
  DatasetService.call(dataset)
end
