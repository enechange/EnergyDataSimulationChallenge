require 'csv'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def import_from_csv(klass, filename)
  CSV.open(Rails.root.join('data', filename), headers: true) do |csv|
    klass.import(
      csv.map(&:to_hash).map { |data| klass.new(data.transform_keys(&:underscore >> :to_sym)) }
    )
  end
end

import_from_csv(Dataset, "dataset_50.csv")
import_from_csv(HouseDatum, "house_data.csv")
