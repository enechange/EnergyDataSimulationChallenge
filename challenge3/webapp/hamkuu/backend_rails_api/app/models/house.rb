class House < ApplicationRecord
  belongs_to :house_owner
  has_many :household_energy_records
end
