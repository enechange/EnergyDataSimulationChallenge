require 'csv'
class DataSetSample < ApplicationRecord
  validates :id, presence: true, numericality: { only_integer: true }
  validates :label, presence: true
  validates :house, presence: true
  validates :year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :month, presence: true, numericality: { only_integer: true }, length: { in: 1..2 }
  validates :temperature, presence: true, numericality: { only_integer: false }
  validates :day_light, presence: true, numericality: { only_integer: false }

  def self.get_average_data
    DataSetSample.group(:year).average(:temperature)
  end

  def self.import(file)
    begin
      CSV.foreach(file, headers: true) do |row|
        house_data = self.find_by(id: row['ID'].to_i) || new
        house_data.attributes = {
            id: row['ID'].to_i,
            label: row['Label'].to_i,
            house: row['House'].to_i,
            year: row['Year'].to_i,
            month: row['Month'].to_i,
            temperature: row['Temperature'].to_f,
            day_light: row['Daylight'].to_f,
            engery_production: row['EnergyProduction'].to_i
        }
        house_data.save!
      end
    rescue => e
      p e.message
      'Error has occoured, check the format of csv'
    end
  end
end
