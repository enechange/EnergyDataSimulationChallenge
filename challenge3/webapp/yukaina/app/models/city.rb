class City < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
