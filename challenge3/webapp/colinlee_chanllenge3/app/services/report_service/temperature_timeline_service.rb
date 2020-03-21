# frozen_string_literal: true

class ReportService::TemperatureTimelineService
  # Build report data for temperature timeline chart.
  #
  # @return [Hash, NilClass], the report data.
  def self.report_data
    EnergyConsume.average_temperature_timeline.each_with_object({}) do |data, report|
      year, month, temperature = data
      report["#{year}/#{month}"] = temperature.round(1).to_s
    end
  end
end
