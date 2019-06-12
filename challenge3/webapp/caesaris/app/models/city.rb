class City < ApplicationRecord
  has_many :houses
  validates :name, uniqueness: true
end
