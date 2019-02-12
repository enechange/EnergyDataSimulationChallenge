class EnergyProduction < ApplicationRecord
  belongs_to :house_energy_usage, foreign_key: 'house'

  def self.import(path)
    require 'csv'

    CSV.foreach(
      path,
      headers: true,
      header_converters: ->(h) { h.underscore.downcase }
    ) do |row|

      create!(row.to_h)
    end
  end
end
