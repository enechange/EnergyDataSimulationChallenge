# frozen_string_literal: true

class EnergyConsume < ApplicationRecord
  belongs_to :house

  # Get the avergate temperature data grouped by year and month
  #
  # @return [Array], array of year, month and average temperature
  def self.average_temperature_timeline
    group(:year, :month).order(:year, :month).pluck(:year, :month, 'AVG(temperature)')
  end
end
