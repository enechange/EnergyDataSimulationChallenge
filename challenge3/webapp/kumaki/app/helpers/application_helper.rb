module ApplicationHelper
  def data_of_temperature(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.year_month, dataset.temperature]
    end
    data
  end

  def data_of_daylight(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.year_month, dataset.daylight]
    end
    data
  end

  def data_of_energey_production(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.year_month, dataset.energy_production]
    end
    data
  end
end
