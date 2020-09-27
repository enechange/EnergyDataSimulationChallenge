# frozen_string_literal: true

class ReportService::CityHouseDaylightService
  def initialize; end

  # Build report data for city daylight chart.
  #
  # @return [Hash, NilClass], the report data.
  def report_data
    House.cities.each_with_object([]) do |city, report|
      sum_house_daylights = House.sum_house_daylights(city)
      item = {
        name:     city,
        daylight: average_house_daylights(sum_house_daylights).round(1).to_s,
      }
      report << item
    end
  end

  private

  # Get the average value for house_daylights.
  #
  # @return [Hash, NilClass], the average house_daylights.
  def average_house_daylights(house_daylights)
    return 0 unless house_daylights.count.positive?

    house_daylights.sum / house_daylights.count
  end
end
