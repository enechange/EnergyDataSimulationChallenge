json.array!(@energies) do |energy|
  json.extract! energy, :id, :label, :house_id, :year, :month, :temperature, :daylight, :energy_production
  json.url energy_url(energy, format: :json)
end
