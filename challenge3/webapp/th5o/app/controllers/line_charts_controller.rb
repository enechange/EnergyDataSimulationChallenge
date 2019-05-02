class LineChartsController < ApplicationController

  def show
    sums = Energy.group(:year_month).sum(:energy_production).sort.to_h
    counts = Energy.group(:year_month).count

    sums.each do |year_month, sum|
      sums[year_month] = {
        sum: sum,
        count: counts[year_month],
        average: sum / counts[year_month].to_f
      }
    end

    @c3_columns = [ c3_header(sums), c3_data(sums) ]
  end

  private

  # ['x', '2011-07-01', '2011-08-01', '2011-09-01', '2011-10-01', '2011-11-01', '2011-12-01']
  def c3_header(sums)
    ary = ['x']
    sums.keys.map do |year_month|
      str = year_month.to_s
      ary.push "#{str[0,4]}-#{str[4,2]}-01"
    end
    ary
  end

  # ['data1', 30, 200, 100, 400, 150, 250]
  def c3_data(sums)
    ary = ['average']
    sums.each do |year_month, hash|
      ary.push hash[:average]
    end
    ary
  end

end
