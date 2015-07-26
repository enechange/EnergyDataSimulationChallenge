json.status      200
json.message     'Successful HTTP requests.'
json.request_id  request.uuid

json.energy_charges do
  json.array! @energy_charges do |charge|
    json.plan_name  charge.plan_name
    json.price      charge.price
  end
end
