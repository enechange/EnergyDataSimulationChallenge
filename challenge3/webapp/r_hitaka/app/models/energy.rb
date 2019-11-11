class Energy < ApplicationRecord
  UPDATABLE_ATTRIBUTES = %w[id label house_id year month temperature daylight energy_production]
  belongs_to :house

  scope :chart_by_year_filter_house, -> (year, id) {where(house: id, year: year).group(:month)}
  scope :chart_by_year_filter_city, -> (year, id) {joins(:house).where(houses: {city: House.find(id).city}, year: year).group(:month)}

  def self.years
    self.all.group(:year).pluck(:year).sort
  end

  def self.chart_energies_production(id)
    years.map {|year| [year, self.chart_by_year_filter_house(year, id).sum(:energy_production)]}.to_h
  end

  def self.chart_energies_average(id)
    years.map {|year| [year, self.chart_by_year_filter_city(year, id).average(:energy_production)]}.to_h
  end

  def self.chart_daylight(id)
    years.map {|year| [year, chart_by_year_filter_city(year, id).average(:daylight)]}.to_h
  end

  def self.import(file)
    transaction do
      CSV.foreach(file.path,
                  headers: true,
                  header_converters: ->(h) {h.try(:downcase).try(:gsub, 'house', 'house_id').try(:gsub, 'energy', 'energy_')}
      ) do |row|
        energy = find_by(id: row["id"]) || new
        energy.attributes = row.to_hash.slice(*UPDATABLE_ATTRIBUTES)
        energy.save!
      end
    end
  end
end
