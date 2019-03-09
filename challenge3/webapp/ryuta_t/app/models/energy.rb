class Energy < ApplicationRecord
  belongs_to :house

  scope :chart_bubble, ->(year) { where(year: year).map { |e| [e.temperature, e.daylight, e.energy_production] } }
end
