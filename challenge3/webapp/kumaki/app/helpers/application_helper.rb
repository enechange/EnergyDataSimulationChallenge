module ApplicationHelper
  def data_of_temperature_with_time(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.year_month, dataset.temperature]
    end
    data
  end

  def data_of_daylight_with_time(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.year_month, dataset.daylight]
    end
    data
  end

  def data_of_energey_production_with_time(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.year_month, dataset.energy_production]
    end
    data
  end

  def data_of_daylight_with_temperature(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.temperature, dataset.daylight]
    end
    data
  end

  def data_of_energy_production_with_daylight(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.daylight, dataset.energy_production]
    end
    data
  end

  def convert_into_yes_or_no(true_or_false)
    if true_or_false
      'YES'
    else
      'NO'
    end
  end
end
