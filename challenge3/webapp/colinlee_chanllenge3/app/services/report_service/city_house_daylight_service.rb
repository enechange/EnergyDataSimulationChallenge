# frozen_string_literal: true

class ReportService::CityHouseDaylightService
  # Build report data for city daylight chart.
  #
  # @return [Hash, NilClass], the report data.
  def self.report_data
    House.cities.each_with_object([]) do |city, report|
      item = {
        name:     city,
        daylight: House.average_house_daylights(city).round(1).to_s,
      }
      report << item
    end
  end
end
