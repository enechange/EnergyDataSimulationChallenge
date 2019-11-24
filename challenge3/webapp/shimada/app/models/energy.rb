class Energy < ApplicationRecord

  belongs_to :house

  validates :label, :house_id, :year, :month, :temperature, :daylight, :energy_production, presence: true
  validates :house_id, uniqueness: { scope: %i[year month] }

  class << self
    def csv_header_converters
      lambda { |name|
        {
          ID:               :id,
          Label:            :label,
          House:            :house_id,
          Year:             :year,
          Month:            :month,
          Temperature:      :temperature,
          Daylight:         :daylight,
          EnergyProduction: :energy_production
        }[name.to_sym] || raise
      }
    end

    def csv_converters
      return nil
    end
  end
end
