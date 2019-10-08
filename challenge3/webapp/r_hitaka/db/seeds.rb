# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Energy.create!(
  id: 1,
  label: 0,
  house_id: 24,
  year: 2004,
  month: 4,
  temperature: 26.2,
  daylight: 178.9,
  energy_production: 800
)

Energy.create!(
  id: 2,
  label: 0,
  house_id: 24,
  year: 2004,
  month: 4,
  temperature: 26.2,
  daylight: 178.9,
  energy_production: 800
)
