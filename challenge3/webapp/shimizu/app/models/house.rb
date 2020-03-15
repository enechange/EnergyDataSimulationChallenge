class House < ApplicationRecord
  has_many :energy_datasets

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true
  validates :has_child, inclusion: { in: [true, false] }
end
