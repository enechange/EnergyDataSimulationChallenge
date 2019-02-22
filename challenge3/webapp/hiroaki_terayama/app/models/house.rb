class House < ApplicationRecord
  enum has_child: { Yes: true, No: false }

  has_many :energy_records

  validates :origin_id, presence: true, numericality: { only_integer: true }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true, numericality: { only_integer: true }
  validates :has_child, presence: true,
end
