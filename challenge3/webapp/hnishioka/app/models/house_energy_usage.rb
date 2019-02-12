class HouseEnergyUsage < ApplicationRecord
  has_many :energy_productions, foreign_key: 'house'

  def self.import(path)
    require 'csv'

    CSV.foreach(
      path,
      headers: true,
      header_converters: ->(h) { h.underscore.downcase }
    ) do |row|

      hash_row = row.to_h
      hash_row['has_child'] = hash_row['has_child'] == 'Yes'
      create!(hash_row)
    end
  end
end
