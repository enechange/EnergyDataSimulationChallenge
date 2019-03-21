class House < ApplicationRecord
  has_many :energies, dependent: :destroy

  validates :firstname, :lastname, :city, :num_of_people, :has_child, presence: true
  validates :firstname, :lastname, length: { maximum: 20 }

  def self.take_energy_average
    group(:city, :year).average(:energy_production).compact.sort.to_h.reduce({}) do |result, (key, value)|
      city, year         = key
      result[city]       ||= {}
      result[city][year] = value
      result
    end
  end

  def self.take_house_amount
    group(:city, :year).count(:id).to_h.reduce({}) do |result, (key, value)|
      city, year         = key
      result[city]       ||= {}
      result[city][year] = value
      result
    end
  end
end