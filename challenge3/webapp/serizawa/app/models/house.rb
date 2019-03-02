class House < ApplicationRecord
  has_many :energies, dependent: :destroy
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true,inclusion: { in: %w(London Oxford Cambridge)}
  validates :num_of_people, presence: true,numericality: { only_integer: true }
  validates :has_child, presence: true,inclusion: { in: %w(Yes No)}
end
