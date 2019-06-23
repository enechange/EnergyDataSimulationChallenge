class DataSeriesService
  def date_labels
    Dataset.select(:year, :month).group(:year, :month)
      .order(:year, :month).map(&:date_str)
  end

  def house_energy_prod
    DataProcess.house_energy_prod_time_series
  end

  def person_energy_prod
    DataProcess.person_energy_prod_time_series
  end

  def temperature
    DataProcess.weather_time_series(:temperature)
  end

  def daylight
    DataProcess.weather_time_series(:daylight)
  end
end
