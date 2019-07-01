require 'rails_helper'

RSpec.describe 'GraphQL on DatasetType' do
  it "Should return all datasets" do
    query = '
      {
        datasets { id }
      }
    '
    data = Util.graphql_query(query)
    expect(data['datasets'].size).to be > 0
  end

  it "Should find datasets by ransack" do
    dataset = Dataset.last
    query = "
      {
        datasets(q: { idEq: #{dataset.id} }) { id, daylight }
      }
    "
    data = Util.graphql_query(query)
    expect(data['datasets'][0]["daylight"]).to eq dataset.daylight
  end

  it "Should find datasets sorted and with pagination" do
    query = '
      {
        datasets(q: { s: "energyProduction desc" }, page: 2, per: 20) {
          id, energyProduction
        }
      }
    '
    data = Util.graphql_query(query)
    expect(data['datasets'].size).to eq 20
  end

  it "Should find datasets sorted by multiple conditions" do
    query = '
      {
        datasets(q: { s: ["temperature desc", "daylight asc"] }, page: 1) {
          id
        }
      }
    '
    data = Util.graphql_query(query)
    expect(data['datasets'].size).to be > 0
  end
end