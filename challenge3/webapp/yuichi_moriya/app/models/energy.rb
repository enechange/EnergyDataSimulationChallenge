class Energy < ApplicationRecord
  belongs_to :house
  
  validates :label, presence: true, numericality: true
  validates :house_id, presence: true, numericality: true
  validates :year, presence: true, numericality: true
  validates :month, presence: true, numericality: true
  validates :temperature, presence: true, numericality: true
  validates :daylight, presence: true, numericality: true
  validates :energy_production, presence: true, numericality: true
  
  def self.periods
    Energy.select('year', 'month').group('year', 'month').order('year', 'month')
  end
end
