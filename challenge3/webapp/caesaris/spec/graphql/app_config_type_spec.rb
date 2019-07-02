require 'rails_helper'

RSpec.describe 'GraphQL on AppConfigType' do
  it "Should Get total_watt_url from challenge2" do
    query = "
      {
        appConfigs { challenge2 { totalWattUrl } }
      }
    "
    data = Util.graphql_query(query)['appConfigs']
    expect(data.dig('challenge2', 'totalWattUrl')).to be_truthy
  end

  it "Should Get house_data_url and dataset_url from challenge3" do
    query = "
      {
        appConfigs { challenge3 { houseDataUrl, datasetUrl } }
      }
    "
    data = Util.graphql_query(query)['appConfigs']
    expect(data.dig('challenge3', 'houseDataUrl')).to be_truthy
    expect(data.dig('challenge3', 'datasetUrl')).to be_truthy
  end
end
