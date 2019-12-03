class House < ApplicationRecord
  has_many :energies

  def fullname
    "#{firstname} #{lastname}"
  end
end
