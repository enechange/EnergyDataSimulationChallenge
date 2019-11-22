class House < ApplicationRecord
  # Association
  has_many :energy_details

  # Validation
  validates :firstname,     presence: true
  validates :lastname,      presence: true
  validates :city,          presence: true, numericality: { only_integer: true }
  validates :num_of_people, presence: true, numericality: { only_integer: true }

  # Enum
  enum city: { cambridge: 0, london: 1, oxford: 2 }
end
