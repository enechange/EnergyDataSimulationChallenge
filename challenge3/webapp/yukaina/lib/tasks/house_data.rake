require "csv"

namespace :house_data do
  desc "house_data.csv を import"
  # bundle exec rake house_data:import FILE_PATH='../../data/house_data.csv'
  task import: :environment do
    # include HouseDataCsvConverter
    file_path = ENV["FILE_PATH"] || "../../data/house_data.csv"
    logger = Logger.new("log/house_data_import.log")
    return logger.info "No File #{file_path}" unless File.exist?(file_path)

    csv_options = {
      headers: true,
      header_converters: HouseDataCsvConverter.headers,
      converters: [HouseDataCsvConverter.fields, :integer],
      skip_blanks: true,
    }

    CSV.foreach(file_path, csv_options) do |csv_row|
      HouseDataImportService.new(csv_row: csv_row).call
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
      logger.error "#{csv_row.inspect}: #{e.message}"
      next
    rescue => e
      logger.fatal "#{csv_row.inspect}: #{e.message}"
    end
  end
end
