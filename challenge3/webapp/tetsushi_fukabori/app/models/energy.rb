class Energy < ApplicationRecord
  belongs_to :house

  validates :label,
            presence: true,
            numericality: { only_integer: true }
  validates :year,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :month,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :temperature,
            presence: true,
            numericality: true
  validates :daylight,
            presence: true,
            numericality: true
  validates :production,
            presence: true,
            numericality: true
end
