require "csv"

namespace :monthly_energy_logs_data do
  desc "dataset_50.csv を import"
  # bundle exec rake monthly_energy_logs_data:import FILE_PATH='../../data/dataset_50.csv'
  task import: :environment do
    file_path = ENV["FILE_PATH"] || "../../data/dataset_50.csv"
    logger = Logger.new("log/monthly_energy_logs_data.log")
    next logger.info "No File #{file_path}" unless File.exist?(file_path)

    next logger.info "bundle exec rake house_data:import FILE_PATH=..." if House.count.zero?

    csv_options = {
      headers: true,
      header_converters: MonthlyEnergyLogsCsvConverter.headers,
      converters: [:integer, :float],
      skip_blanks: true,
    }

    CSV.foreach(file_path, csv_options) do |csv_row|
      MonthlyEnergyLogsImportService.new(csv_row: csv_row).call
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
      logger.error "#{csv_row.inspect}: #{e.message}"
      next
    rescue => e
      logger.fatal "#{csv_row.inspect}: #{e.message}"
    end
  end
end
