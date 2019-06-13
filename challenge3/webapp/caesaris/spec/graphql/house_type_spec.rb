require 'rails_helper'

RSpec.describe 'GraphQL on HouseType' do
  it "Should exec house query" do
    query = "
      {
        house(id: 1) { firstname, lastname }
      }
    "
    data = Util.graphql_query(query)
    house = House.find(1)
    expect(data.dig('house', 'firstname')).to eq house.firstname
    expect(data.dig('house', 'lastname')).to eq house.lastname
  end

  it "Should find city from house query" do
    query = "
      {
        house(id: 2) { city { name } }
      }
    "
    data = Util.graphql_query(query)
    city = House.find(2).city
    expect(data.dig('house', 'city', 'name')).to eq city.name
  end

  it "Should find houses by ransack like query" do
    query = '
      {
        houses(queryJson: "{\"idEq\": 3}") { id, firstname }
      }
    '
    data = Util.graphql_query(query)
    house = House.find(3)
    expect(data['houses'][0]["firstname"]).to eq house.firstname
  end
end
