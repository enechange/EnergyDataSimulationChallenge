json.status      @charge_response.status
json.message     @charge_response.message
json.request_id  @charge_response.request_id

json.energy_charges do
  json.array! @charge_response.energy_charges do |charge|
    json.plan_name  charge.plan_name
    json.price      charge.price
  end
end
