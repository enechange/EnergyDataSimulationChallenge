class MonthlyEnergyLogsFinder
  def self.averages
    MonthlyEnergyLog.
      group_by_monthly_label.
      select(
        :monthly_label_id,
        "AVG(temperature) AS avarage_temperature",
        "AVG(daylight) AS avarage_daylight",
        "AVG(production_volume) AS avarage_production_volume",
      ).
      includes(:monthly_label)
  end

  def self.by_city
    MonthlyEnergyLog.
      select(
        "SUM(temperature) AS total_temperature",
        "SUM(daylight) AS total_daylight",
        "SUM(production_volume) AS total_production_volume",
        "cities.name AS city_name",
      ).
      joins(house: :city).
      group("city_name, cities.id").
      order("cities.id")
  end
end
