json.array!(@dataset) do |data|
  json.Date data[0]
  json.Production data[1]
  json.Temperature data[2]
  json.Daylight data[3]
end
