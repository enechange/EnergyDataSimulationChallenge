class Energy < ApplicationRecord
  belongs_to :house
  using ArrayStatistics

  scope :city_place, lambda { |city_selection|
    city_selection == 'All' ? all : joins(:house).where('houses.city = ?', city_selection)
  }

  def self.monthly_average(energies)
    @monthly_energies = {}
    @labels = []
    @temperatures = []
    @daylights = []
    @energy_productions = []

    energies.group_by(&:label).each do |key, value|
      @labels << key
      @temperatures << value.map(&:temperature).average
      @daylights << value.map(&:daylight).average
      @energy_productions << value.map(&:energy_production).average
    end
    @monthly_energies = {
      labels: @labels,
      temperatures: @temperatures,
      daylights: @daylights,
      energy_productions: @energy_productions
    }
  end
end
