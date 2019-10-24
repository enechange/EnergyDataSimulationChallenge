require "csv"

namespace :house_data_csv do
  desc "import from house_data.csv"
  task import: :environment do
    file_path = "db/data/house_data.csv"
    logger = Logger.new("log/import_house_data.log")
    next logger.info "No File #{file_path}" unless File.exist?(file_path)

    csv_options = {
      headers: true,
      header_converters: HouseDataCsvConverter.headers,
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
