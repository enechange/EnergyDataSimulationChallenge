class MonthlyEnergyLogsImportService
  def initialize(csv_row:)
    @csv_row = csv_row
  end

  def call
    ActiveRecord::Base.transaction do
      monthly_label = MonthlyLabel.find_or_create_by!(id: @csv_row[:monthly_label_id], year: @csv_row[:year], month: @csv_row[:month])
      house = House.find(@csv_row[:house_id])
      MonthlyEnergyLog.create!(
        @csv_row.to_h.slice(:id, :temperature, :daylight, :production_volume).
          merge(monthly_label: monthly_label, house: house, family: house.family),
      )
    end
  end
end
