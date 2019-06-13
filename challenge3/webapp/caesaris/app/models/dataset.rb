class Dataset < ApplicationRecord
  belongs_to :house
  delegate :city, to: :house
  validates_presence_of :label, :year, :month, :temperature, :daylight, :energy_production

  def date_str
    "#{year}-#{month}"
  end

end

# Columns:
# label, house_id, year, month, temperature, daylight, energy_production
