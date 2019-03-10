class House < ApplicationRecord
  has_many :energies

  validates :firstname, :lastname, :city, :num_of_people, :has_child, presence: true
  validates :firstname, :lastname, length: { maximum: 20 }

  scope :extract_chart_data, ->(city, year, column) { where(city: city).map { |y| y.energies.where(year: year).map(&column) } }

  scope :production_average, ->(city, year, column) { production_sum(city, year, column) / house_amount(city, year, column) }

  scope :production_sum, ->(city, year, column) { extract_chart_data(city, year, column).sum.sum }

  scope :house_amount, ->(city, year, column) { extract_chart_data(city, year, column).flatten!.count }

end