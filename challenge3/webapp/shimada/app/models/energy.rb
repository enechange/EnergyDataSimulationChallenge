class Energy < ApplicationRecord

  belongs_to :house

  validates :label, :house_id, :year, :month, :temperature, :daylight, :energy_production, presence: true
  validates :house_id, uniqueness: { scope: %i[year month] }

end
