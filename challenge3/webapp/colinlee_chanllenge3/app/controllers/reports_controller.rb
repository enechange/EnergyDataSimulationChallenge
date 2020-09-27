# frozen_string_literal: true

class ReportsController < ApplicationController
  # Render the json of the average temperature for every month
  def temperature_timeline
    report_service = ReportService::TemperatureTimelineService.new

    render json: report_service.report_data
  end

  # Render the json of the sum daylight for every city
  def city_daylight
    report_service = ReportService::CityHouseDaylightService.new

    render json: report_service.report_data
  end
end
