class House < ApplicationRecord
  # relation
  has_many :energies

  # attribute
  include City::Attribute
end
