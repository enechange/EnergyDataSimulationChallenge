class House < ApplicationRecord
  belongs_to :city
  has_many :energies
  
  validates :firstname, presence: true, length: { maximum: 50 }
  validates :lastname, presence: true, length: { maximum: 50 }
  validates :num_of_people, presence: true, numericality: { only_integer: true }
end
