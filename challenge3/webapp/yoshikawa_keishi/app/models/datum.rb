class Datum < ApplicationRecord
  belongs_to :house

  validates :csv_id, presence: true, numericality: { only_integer: true }
  validates :label, presence: true, numericality: { only_integer: true }
  validates :house_id, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 13 }
  validates :temperature, presence: true
  validates :daylight, presence: true
  validates :energy_production, presence: true, numericality: { only_integer: true }

  def self.import(file)
    CSV.foreach(file, headers: true) do |row|
      datum = new(
        house:             House.find_by(csv_id: row['House']),
        csv_id:            row["ID"],
        label:             row["Label"],
        year:              row["Year"],
        month:             row["Month"],
        temperature:       row["Temperature"],
        daylight:         row["Daylight"],
        energy_production:  row["EnergyProduction"])
      datum.save!
    end
  end

  def month_of_year 
    "#{self.year}/#{self.month}"
  end

  def self.city_energy_production
    joins(:house).group('houses.city').sum('data.energy_production')
  end

end
