class CityChartService
  private_class_method :new

  def self.call(cities)
    new.call(cities)
  end

  def call(cities)
    cities.select(:id, :name).map do |city|
      {
        name: city.name,
        data: city.energies
                  .group(:year, :month)
                  .order(:year, :month)
                  .sum(:energy_production)
      }
    end
  end
end
