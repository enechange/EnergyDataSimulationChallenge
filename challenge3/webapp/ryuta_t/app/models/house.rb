class House < ApplicationRecord
  has_many :energies

  scope :create_chart, ->(city, year, column){where(city: city).map { |y| y.energies.where(year: year).map(&column) }}

  scope :chart_sum, ->(city, year, column){create_chart(city, year, column).sum.sum}

  scope :chart_count, ->(city, year, column){create_chart(city, year, column).flatten!.count}

  scope :akamai, ->(city, year, column){chart_sum(city, year, column) / chart_count(city, year, column)}
end
