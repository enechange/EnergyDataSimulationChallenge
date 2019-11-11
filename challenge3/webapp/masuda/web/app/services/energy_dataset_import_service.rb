class EnergyDatasetImportService
  def initialize(csv_row:)
    @csv_row = csv_row
  end

  def call
    ActiveRecord::Base.transaction do
      EnergyProduction.find_or_create_by!(
        label: @csv_row[:label],
        house_id: @csv_row[:house_id],
        year: @csv_row[:year],
        month: @csv_row[:month],
        temperature: @csv_row[:temperature],
        daylight: @csv_row[:daylight],
        energy_production: @csv_row[:energy_production],
      )
    end
  end
end
