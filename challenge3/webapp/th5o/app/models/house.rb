class House < ApplicationRecord
  # relation
  has_many :energies

  # attribute
  include City::Attribute

  # scope
  scope :num_of_peoples, ->(num) {
    where(num_of_people: num)
  }
  scope :has_children, ->(bool) {
    where(has_child: bool)
  }
  scope :cities, ->(city) {
    where(city: city)
  }
end
