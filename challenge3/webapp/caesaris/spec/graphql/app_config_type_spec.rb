require 'rails_helper'

RSpec.describe 'GraphQL on AppConfigType' do
  it "Should Get total_watt_url from challenge2" do
    query = <<~GQL
      {
        appConfigs { challenge2 { totalWattUrl } }
      }
    GQL
    data = Util.graphql_query(query)['appConfigs']
    expect(data.dig('challenge2', 'totalWattUrl')).to be_truthy
  end

  it "Should Get house_data_url and dataset_url from challenge3" do
    query = <<~GQL
      {
        appConfigs { challenge3 { houseDataUrl, datasetUrl } }
      }
    GQL
    data = Util.graphql_query(query)['appConfigs']
    expect(data.dig('challenge3', 'houseDataUrl')).to be_truthy
    expect(data.dig('challenge3', 'datasetUrl')).to be_truthy
  end

  it "Should return all app_configs" do
    query = <<~GQL
      {
        appConfigs {
          general { allowGraphiql }
          challenge2 { totalWattUrl }
          challenge3 { datasetUrl, houseDataUrl }
          fieldKeys
        }
      }
    GQL

    data = Util.graphql_query(query).deep_symbolize_keys
    data = data[:appConfigs]

    expect(data[:general][:allowGraphiql]).to eq AppConfig.general[:allow_graphiql]
    expect(data[:challenge2][:totalWattUrl]).to eq AppConfig.challenge2[:total_watt_url]
    expect(data[:challenge3][:datasetUrl]).to eq AppConfig.challenge3[:dataset_url]
    expect(data[:challenge3][:houseDataUrl]).to eq AppConfig.challenge3[:house_data_url]
    expect(data[:fieldKeys].size).to be > 0
  end
end
