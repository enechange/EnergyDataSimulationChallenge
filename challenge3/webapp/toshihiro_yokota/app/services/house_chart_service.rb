class HouseChartService
  private_class_method :new

  def self.call(houses)
    new.call(houses)
  end

  def call(houses)
    houses.select(:energy_production)
          .group(:id)
          .sum(:energy_production)
  end
end
