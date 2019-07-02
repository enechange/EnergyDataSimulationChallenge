class MonthlyLabel < ApplicationRecord
  with_options presence: true do
    validates :year
    validates :month
  end
  validates :year, uniqueness: { scope: :month }
end
