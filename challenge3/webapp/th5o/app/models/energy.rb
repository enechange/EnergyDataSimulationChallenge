class Energy < ApplicationRecord
  # relation
  belongs_to :house

  # scope
  scope :num_of_peoples, ->(num) {
    joins(:house).merge(House.num_of_peoples(num))
  }
  scope :has_children, ->(bool) {
    joins(:house).merge(House.has_children(bool))
  }
  scope :cities, ->(city) {
    joins(:house).merge(House.cities(city))
  }
end
