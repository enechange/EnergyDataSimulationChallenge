class House < ApplicationRecord
  has_many :energies
  belongs_to :city
end
