class House < ApplicationRecord
  has_many :energies
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true,numericality: { only_integer: true }
  validates :has_child, presence: true,inclusion: { in: %w(Yes No)}
end
