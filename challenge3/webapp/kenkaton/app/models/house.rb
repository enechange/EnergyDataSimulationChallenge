class House < ApplicationRecord
  has_many :energies
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, numericality: true, presence: true
end
