# frozen_string_literal: true

class ReportService::TemperatureTimelineService
  def initialize; end

  # Build report data for temperature timeline chart.
  #
  # @return [Hash, NilClass], the report data.
  def report_data
    EnergyConsume.average_temperature_timeline.each_with_object([]) do |data, report|
      year, month, temperature = data
      item = {
        name:        "#{year}/#{month}",
        temperature: temperature.round(1).to_s,
      }
      report << item
    end
  end
end
