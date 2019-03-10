class House < ApplicationRecord
  has_many :energies

  validates :firstname, :lastname, :city, :num_of_people, :has_child, presence: true
  validates :firstname, :lastname, length: { maximum: 20 }

  def self.include_data_for_chart(city, year, data)
    where(city: city).map { |e| e.energies.where(year: year).pluck(data) }
  end

  def self.average_production(city, year, data)
    sum_production(city, year, data) / count_houses(city, year, data)
  end

  def self.count_houses(city, year, data)
    include_data_for_chart(city, year, data).flatten!.count
  end

  def self.sum_production(city, year, data)
    include_data_for_chart(city, year, data).sum.sum
  end
end
