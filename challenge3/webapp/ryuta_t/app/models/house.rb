class House < ApplicationRecord
  has_many :energies

  def self.create_chart(city, year, column)
    where(city: city).map { |y| y.energies.where(year: year).map(&column) }
  end

  def self.chart_sum(city, year, column)
    create_chart(city, year, column).sum.sum
  end

  def self.chart_count(city, year, column)
    create_chart(city, year, column).flatten!.count
  end

  def self.akamai(city, year, column)
    chart_sum(city, year, column) / chart_count(city, year, column)
  end
end
