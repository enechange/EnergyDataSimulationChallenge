class City < ActiveRecord::Base
  has_many :houses
  has_many :city_energies
end
