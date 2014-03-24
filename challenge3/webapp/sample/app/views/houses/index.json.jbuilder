json.array!(@houses) do |house|
  json.extract! house, :id, :firstname, :lastname, :city, :num_of_people, :has_child
  json.url house_url(house, format: :json)
end
