class House < ApplicationRecord
  has_many :energies
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true
  validates :has_child, presence: true

  scope :same_condition, lambda { |house|
    city = house.city
    num_of_people = house.num_of_people
    has_child = house.has_child
    House.where(city: city, num_of_people: num_of_people, has_child: has_child)
  }
end
