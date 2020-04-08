module ApplicationHelper
  def data_of_temperature_with_time(datasets)
    datasets.map { |dataset| [dataset.year_month, dataset.temperature] }
  end

  def data_of_daylight_with_time(datasets)
    datasets.map { |dataset| [dataset.year_month, dataset.daylight] }
  end

  def data_of_energy_production_with_time(datasets)
    datasets.map { |dataset| [dataset.year_month, dataset.energy_production] }
  end

  def data_of_daylight_with_temperature(datasets)
    datasets.map { |dataset| [dataset.temperature, dataset.daylight] }
  end

  def data_of_energy_production_with_daylight(datasets)
    datasets.map { |dataset| [dataset.daylight, dataset.energy_production] }
  end

  def convert_into_yes_or_no(boolean)
    boolean ? 'Yes' : 'No'
  end

  def data_of_city_with_count(houses)
    houses.map { |house| [house.city_name, house.count_all] }.to_h
  end

  def data_of_has_child_with_count(houses)
    houses.map { |house| [convert_into_yes_or_no(house.has_child), house.count_all] }.to_h
  end

  def data_of_num_of_people_with_count(houses)
    houses.map { |house| [house.num_of_people, house.count_all] }.to_h
  end
end
