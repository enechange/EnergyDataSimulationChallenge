# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Load seed from each seeds/*.rb files.
Dir.glob(File.join(Rails.root, 'db', 'seeds', '*.rb')).sort.each do |file|
  load(file)
end
