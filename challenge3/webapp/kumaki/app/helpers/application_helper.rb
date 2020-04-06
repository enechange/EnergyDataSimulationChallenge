module ApplicationHelper
  def data_of_temperature(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.date, dataset.temperature]
    end
    data
  end

  def data_of_daylight(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.date, dataset.daylight]
    end
    data
  end

  def data_of_energey_production(datasets)
    data = []
    datasets.each do |dataset|
      data << [dataset.date, dataset.energy_production]
    end
    data
  end
end
