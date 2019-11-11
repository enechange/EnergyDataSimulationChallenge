require "csv"

namespace :data_set_50_csv do
  desc "import from dataset_50.csv"
  task import: :environment do
    file_path = "db/data/dataset_50.csv"
    logger = Logger.new("log/import_dataset_50.log")
    next logger.info "No File #{file_path}" unless File.exist?(file_path)

    csv_options = {
      headers: true,
      header_converters: EnergyDatasetCsvConverter.headers,
      skip_blanks: true,
    }

    CSV.foreach(file_path, csv_options) do |csv_row|
      EnergyDatasetImportService.new(csv_row: csv_row).call
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique => e
      logger.error "#{csv_row.inspect}: #{e.message}"
      next
    rescue => e
      logger.fatal "#{csv_row.inspect}: #{e.message}"
    end
  end
end
