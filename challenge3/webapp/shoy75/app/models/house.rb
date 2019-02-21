class House < ApplicationRecord
  has_many :energies

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true
  validates :has_child, inclusion: { in: [true, false] }

  def full_name
    "#{firstname} #{lastname}"
  end
end
