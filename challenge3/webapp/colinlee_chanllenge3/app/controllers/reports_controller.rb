# frozen_string_literal: true

class ReportsController < ApplicationController
  # Render the json of the average temperature for every month
  def temperature_timeline
    render json: ReportService::TemperatureTimelineService.report_data
  end

  # Render the json of the sum daylight for every city
  def city_daylight
    render json: ReportService::CityHouseDaylightService.report_data
  end
end
