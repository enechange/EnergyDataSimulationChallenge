class Energy < ApplicationRecord
  belongs_to :house

  validates :label, :house_id, :year, :month, :temperature, :daylight, :energy_production, presence: true

  def include_energy_data(year)
    where(year: year).map { |e| [e.temperature, e.daylight, e.energy_production] }
  end

end
