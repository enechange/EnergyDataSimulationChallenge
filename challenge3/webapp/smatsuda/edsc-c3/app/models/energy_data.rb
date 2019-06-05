class EnergyData < ApplicationRecord
  belongs_to :house, optional: true
end
