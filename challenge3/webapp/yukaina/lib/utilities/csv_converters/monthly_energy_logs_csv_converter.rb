class MonthlyEnergyLogsCsvConverter
  def self.headers
    ->(header) do
      {
        "ID" => :id,
        "Label" => :monthly_label_id,
        "House" => :house_id,
        "Year" => :year,
        "Month" => :month,
        "Temperature" => :temperature,
        "Daylight" => :daylight,
        "EnergyProduction" => :production_volume,
      }[header]
    end
  end
end
