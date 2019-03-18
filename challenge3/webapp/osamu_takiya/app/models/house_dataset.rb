class HouseDataset < ApplicationRecord
  has_many :energy_production_datasets, dependent: :destroy

  validates :firstname,
            presence: true
  validates :lastname,
            presence: true
  validates :city,
            presence: true,
            inclusion: { in: %w(London Cambridge Oxford) }
  validates :num_of_people,
            presence: true,
            numericality: { only_integer: true }
  validates :has_child,
            inclusion: { in: [true, false] }
end
