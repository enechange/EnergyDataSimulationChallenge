# frozen_string_literal: true

class House < ApplicationRecord
  has_many :energy_consumes, dependent: :destroy

  # Get the sum of daylight
  #
  # @return [Float], sum of total daylight
  def sum_daylights
    energy_consumes.map(&:daylight).sum
  end

  # Get the average of house daylight with given city
  #
  # @param city[String], city name
  #
  # @return [Float], average house daylight of input city
  def self.average_house_daylights(city)
    house_sum_daylights = where(city: city).map(&:sum_daylights)
    return 0 unless house_sum_daylights.count.positive?

    house_sum_daylights.sum / house_sum_daylights.count
  end

  # Get the list of cities
  #
  # @return [Array]<String>, list of all the cities
  def self.cities
    all.map(&:city).uniq
  end
end
