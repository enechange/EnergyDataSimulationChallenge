# frozen_string_literal: true

class House < ApplicationRecord
  has_many :energy_consumes, dependent: :destroy

  validates :uuid, presence: true, uniqueness: true
  validates :living_count, presence: true
  validates :has_child, inclusion: { in: [true, false] }

  # Get the sum of daylight
  #
  # @return [Float], sum of total daylight
  def sum_daylights
    energy_consumes.map(&:daylight).sum
  end

  # Get the sum of house daylight with given city
  #
  # @param city[String], city name
  #
  # @return [Float], sum house daylight of input city
  def self.sum_house_daylights(city)
    where(city: city).map(&:sum_daylights)
  end

  # Get the list of uniq cities
  #
  # @return [Array]<String>, list of all the cities
  def self.cities
    distinct.pluck(:city)
  end
end
