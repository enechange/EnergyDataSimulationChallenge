class MonthlyEnergyLog < ApplicationRecord
  belongs_to :monthly_label
  belongs_to :house
  belongs_to :family
end
