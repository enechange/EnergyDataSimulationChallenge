json.array!(@cities) do |city|
  json.extract! city, :id, :name, :count_house, :total_energy_production
end
