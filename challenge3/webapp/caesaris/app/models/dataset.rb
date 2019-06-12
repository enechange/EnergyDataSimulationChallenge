class Dataset < ApplicationRecord
  belongs_to :house
  validates_presence_of :label, :year, :month, :temperature, :daylight, :energy_production
end

# Columns:
# label, house_id, year, month, temperature, daylight, energy_production
