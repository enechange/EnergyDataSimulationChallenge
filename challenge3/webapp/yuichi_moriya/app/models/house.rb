class House < ApplicationRecord
  validates :firstname, presence: true, length: { maximum: 255 }
  validates :lastname, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 255 }
  validates :num_of_people, presence: true, numericality: true
  validates :has_child, presence: true, inclusion: { in: [true, false] }
  
  has_many :energies
end
