class City < ApplicationRecord
  has_many :houses;
  has_many :city_energies
end
