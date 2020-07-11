class House < ApplicationRecord
  has_many :energies, dependent: :destroy, foreign_key: 'house_id'

  scope :house_city_counts, -> {joins(:energies).select('city').group('city').order('city').count}
  scope :city_energy_production, -> {joins(:energies).group('year').group('month').group('city').average('energy_production')}
end
