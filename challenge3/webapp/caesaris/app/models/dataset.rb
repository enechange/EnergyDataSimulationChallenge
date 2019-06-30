class Dataset < ApplicationRecord
  belongs_to :house
  has_one :city, through: :house
  validates_presence_of :label, :year, :month, :temperature, :daylight, :energy_production

  scope :order_by_date, -> { order(:year, :month) }

  def date_str
    "#{year}-#{month}"
  end

end

# Columns:
# label, house_id, year, month, temperature, daylight, energy_production
