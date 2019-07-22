class House < ApplicationRecord
  has_many :energies
  validates :first_name, presence: true
  validates :last_name , presence: true
  validates :city , presence: true
  validates :num_of_people , presence: true
  validates :has_child , presence: true

  scope :select_city, -> (city) {
    if city == 'all'
      joins(:energies)
    else
      joins(:energies).group(:city).where("city= ? ", city)
    end
  }

  scope :sum_data, lambda {
    group(:label).select('
      AVG(year * 100 + month) as date,
      AVG(temperature) as ave_temperature,
      AVG(daylight) as ave_daylight,
      AVG(energyproduction) as ave_production
    ').map {|e| [e.date.to_i , e.ave_temperature, e.ave_daylight, e.ave_production.to_f] }.sort
  }
end
