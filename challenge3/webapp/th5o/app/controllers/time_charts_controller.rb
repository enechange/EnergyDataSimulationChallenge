class TimeChartsController < ApplicationController

  def show
    whole = Energy.group(:year_month).average(:energy_production).sort.to_h

    @c3_columns = []
    @c3_columns.push c3_header(whole)
    @c3_columns.push c3_data('whole household', whole)

    # optional data
    ary = optional_data(params[:show_with])
    ary.each { |data| @c3_columns.push data }
  end

  private

  # ['x', '2011-07-01', '2011-08-01', '2011-09-01', '2011-10-01', '2011-11-01', '2011-12-01']
  def c3_header(whole)
    ary = ['x']
    whole.keys.map do |year_month|
      str = year_month.to_s
      ary.push "#{str[0,4]}-#{str[4,2]}-01"
    end
    ary
  end

  # ['data1', 30, 200, 100, 400, 150, 250]
  def c3_data(label, data)
    ary = [label]
    ary.push(*data.values)
    ary
  end

  def optional_data(show_with)
    case show_with
    when "num_of_people"
      energy_data_segmented_by_people
    when "has_child"
      energy_data_segmented_by_child
    when "city"
      energy_data_segmented_by_city
    else
      []
    end
  end

  def energy_data_segmented_by_people
    ary = []
    nums = House.pluck(:num_of_people).uniq
    nums.each do |num|
      ary.push c3_data("n=#{num}", Energy.num_of_peoples(num).group(:year_month).average(:energy_production).sort.to_h)
    end
    ary
  end

  def energy_data_segmented_by_child
    ary = []
    bools = [true, false]
    bools.each do |bool|
      ary.push c3_data("has_child: #{bool}", Energy.has_children(bool).group(:year_month).average(:energy_production).sort.to_h)
    end
    ary
  end

  def energy_data_segmented_by_city
    ary = []
    names = City.names
    names.each do |name|
      ary.push c3_data(name.to_s, Energy.cities(name).group(:year_month).average(:energy_production).sort.to_h)
    end
    ary
  end

end
