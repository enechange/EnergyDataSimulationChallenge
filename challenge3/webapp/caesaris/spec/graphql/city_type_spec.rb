require 'rails_helper'

RSpec.describe 'GraphQL on CityType' do
  it "Should find city by name" do
    city = City.all.last
    query = "
      {
        city(name: \"#{city.name}\") { id, name }
      }
    "
    data = Util.graphql_query(query)
    expect(data.dig('city', 'id')).to eq city.id.to_s
  end

  it "Should find city by ransack like query" do
    city = House.find(1).city
    query = '
      {
        cities(queryJson: "{\"houses_id_eq\": 1}") { id, name }
      }
    '
    data = Util.graphql_query(query)
    expect(data['cities'][0]["name"]).to eq city.name
  end

  it "Should return all cities" do
    city_num = City.all.size
    query = '
      {
        cities { id, name }
      }
    '
    data = Util.graphql_query(query)
    expect(data['cities'].size).to eq city_num
  end
end
