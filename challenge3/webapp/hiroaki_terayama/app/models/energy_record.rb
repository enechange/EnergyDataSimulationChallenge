require 'csv'
class EnergyRecord < ApplicationRecord
  # TODO: origin_idを主キーにする(?)
  belongs_to :house

  validates :origin_id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :label, presence: true, numericality: { only_integer: true }
  validates :house_origin_id, presence: true, numericality: { only_integer: true }
  validates :year, presence: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :month, presence: true, numericality: { only_integer: true }, length: { in: 1..2 }
  validates :temperature, presence: true, numericality: { only_integer: false }
  validates :daylight, presence: true, numericality: { only_integer: false }
  validates :energy_production, presence: true

  def self.import_csv(path)
    # TODO: houseと関係付ける必要ある？
    begin
      data_array = []
      CSV.foreach(path, headers: true) do |row|
        data = EnergyRecord.find_by(origin_id: row['ID'].to_i) || new
        if data.id
          set_attributes(data, row)
          data.save!
        else
          data_array << set_attributes(data, row)
        end
      end
      self.import(data_array)
    end
  rescue => e
    # TODO: 例外処理する
    p e
  end

  private
    def self.set_attributes(data, row)
      data.attributes = {
          origin_id: row['ID'].to_i,
          label: row['Label'].to_i,
          house_origin_id: row['House'].to_i,
          year: row['Year'].to_i,
          month: row['Month'].to_i,
          temperature: row['Temperature'].to_f,
          daylight: row['Daylight'].to_f,
          energy_production: row['EnergyProduction'].to_i,
          house_id: House.find_by(origin_id: row['House'].to_i)&.id
      }
    end
end
