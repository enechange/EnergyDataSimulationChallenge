json.array!(@cities) do |city|
  json.name city[0]
  json.count city[1]
end
