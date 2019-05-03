class BarChartsController < ApplicationController

  def show
    hash = category_data(params['category'] || 'num_of_people')

    @c3_columns = hash[:columns]
    @c3_categories = hash[:categories]
    @c3_minmax = c3_minmax(hash[:data]) if (params['focus'] || false)
  end

  private

  # ['data1', 30, 200, 100, 400, 150, 250]
  def c3_data(label, data)
    ary = [label]
    ary.push(*data)
    ary
  end

  # "min: 610, max: 630,"
  def c3_minmax(data)
    min, max = data.minmax
    "min: #{min.to_i}, max: #{max.to_i},"
  end

  def category_data(category)
    case category
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
      ary.push Energy.num_of_peoples(num).average(:energy_production)
    end

    {
      columns: c3_data('category: num_of_people', ary),
      categories: nums,
      data: ary
    }
  end

  def energy_data_segmented_by_child
    ary = []
    bools = [true, false]
    bools.each do |bool|
      ary.push Energy.has_children(bool).average(:energy_production)
    end

    {
      columns: c3_data('category: has_child', ary),
      categories: bools,
      data: ary
    }
  end

  def energy_data_segmented_by_city
    ary = []
    names = City.names
    names.each do |name|
      ary.push Energy.cities(name).average(:energy_production)
    end

    {
      columns: c3_data('category: city', ary),
      categories: names,
      data: ary
    }
  end

end
