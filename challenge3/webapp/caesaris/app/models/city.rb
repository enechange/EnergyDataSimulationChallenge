class City < ApplicationRecord
  has_many :houses
  has_many :datasets, through: :houses
  validates :name, uniqueness: true
end
