class House < ApplicationRecord

  has_many :energies

  validates :firstname, :lastname, :city, :num_of_people, presence: true
  validates :city, inclusion: { in: CITIES }
  validates :has_child, inclusion: { in: [true, false] }

end
