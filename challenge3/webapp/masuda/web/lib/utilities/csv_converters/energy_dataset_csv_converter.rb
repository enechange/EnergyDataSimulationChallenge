class EnergyDatasetCsvConverter
  def self.headers
    ->(header) do
      {
        "ID" => :id,
        "Label" => :label,
        "House" => :house_id,
        "Year" => :year,
        "Month" => :month,
        "Temperature" => :temperature,
        "Daylight" => :daylight,
        "EnergyProduction" => :energy_production,
      }[header]
    end
  end
end