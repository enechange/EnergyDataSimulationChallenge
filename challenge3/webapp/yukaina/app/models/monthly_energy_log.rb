class MonthlyEnergyLog < ApplicationRecord
  belongs_to :monthly_label
  belongs_to :house
  belongs_to :family
  with_options presence: true, numericality: true do
    validates :temperature
    validates :daylight
    validates :production_volume
  end
  scope :group_by_monthly_label, -> { group(:monthly_label_id) }
end
