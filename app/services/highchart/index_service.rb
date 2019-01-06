class Highchart::IndexService
  attr_reader :form

  def initialize(form)
    @form = form
  end

  def execute
    house_ids = House.with_city(form.cap_city)
                     .with_num_of_people(form.num_of_people)
                     .pluck(:id)

    data_sets = DataSet.with_house_ids(house_ids)
                       .order_by_date
                       .group_by(&:collect_date)
                       .map do |collect_date, data_sets_per_month|
                         next unless form.in_time?(collect_date)
                         calc_avg(init_avg_data_set(collect_date), data_sets_per_month)
                       end

    data_sets.compact
  end

  def init_avg_data_set(collect_date)
    OpenStruct.new({
      collect_date: collect_date,
      temperature: 0.0,
      daylight: 0.0,
      energy_production: 0.0,
    })
  end

  def calc_avg(avg_data_set, data_sets)
    data_sets.each do |data_set|
      avg_data_set.temperature += data_set.temperature
      avg_data_set.daylight += data_set.daylight
      avg_data_set.energy_production += data_set.energy_production
    end

    avg_data_set.temperature = (avg_data_set.temperature / data_sets.size).ceil(2)
    avg_data_set.daylight = (avg_data_set.daylight / data_sets.size).ceil(2)
    avg_data_set.energy_production = (avg_data_set.energy_production / data_sets.size).ceil(2)

    avg_data_set
  end
end
