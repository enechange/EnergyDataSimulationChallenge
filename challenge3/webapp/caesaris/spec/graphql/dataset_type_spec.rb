require "rails_helper"

RSpec.describe "GraphQL on DatasetType" do
  it "Should return all datasets" do
    query = <<~GRAPHQL
      {
        datasets { id }
      }
    GRAPHQL
    data = Util.graphql_query(query)
    expect(data["datasets"].size).to be > 0
  end

  it "Should find datasets by ransack" do
    dataset = Dataset.last
    query = <<~GRAPHQL
      {
        datasets(q: { idEq: #{dataset.id} }) { id, daylight }
      }
    GRAPHQL
    data = Util.graphql_query(query)
    expect(data["datasets"][0]["daylight"]).to eq dataset.daylight
  end

  it "Should find datasets sorted and with pagination" do
    query = <<~GRAPHQL
      {
        datasets(q: { s: "energyProduction desc" }, page: 2, per: 20) {
          id, energyProduction
        }
      }
    GRAPHQL
    data = Util.graphql_query(query)
    expect(data["datasets"].size).to eq 20
  end

  it "Should find datasets sorted by multiple conditions" do
    query = <<~GRAPHQL
      {
        datasets(q: { s: ["temperature desc", "daylight asc"] }, page: 1) {
          id
        }
      }
    GRAPHQL
    data = Util.graphql_query(query)
    expect(data["datasets"].size).to be > 0
  end
end
