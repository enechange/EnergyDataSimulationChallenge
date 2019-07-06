require 'rails_helper'

RSpec.describe 'GraphQL Mutation on AppConfigs' do
  it "Create dummy users" do
    email = "admin-user-gql@example.org"
    pass = "12345678"
    @admin_user = User.create!({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ['admin']
    })
    email = "nomal-user-gql@example.org"
    @normal_user = User.create!({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ['observer']
    })
    expect(@admin_user).to be_truthy
    expect(@normal_user).to be_truthy
  end

  it "Should update challenge2" do
    context = { current_user: User.admin.first }
    dummy_url = "https://example.org/total_watt_url.csv"
    query = <<~GRAPHQL
      mutation {
        updateAppConfig(
          input: {
            appConfigs: { challenge2: { totalWattUrl: "#{dummy_url}" } }
          }
        ) { appConfigs { challenge2 { totalWattUrl } } }
      }
    GRAPHQL
    data = Util.graphql_query(query, context: context)
      .dig('updateAppConfig', 'appConfigs')
    expect(data['challenge2']['totalWattUrl']).to eq dummy_url
  end

  it "Should update challenge3 partial" do
    context = { current_user: User.admin.first }
    dummy_url = "https://example.com/house_data_url.csv"
    query = <<~GRAPHQL
      mutation {
        updateAppConfig(
          input: {
            appConfigs: { challenge3: { houseDataUrl: "#{dummy_url}" } }
          }
        ) { appConfigs { challenge3 { houseDataUrl, datasetUrl } } }
      }
    GRAPHQL
    data = Util.graphql_query(query, context: context)
      .dig('updateAppConfig', 'appConfigs')
    expect(data['challenge3']['houseDataUrl']).to eq dummy_url
    expect(data['challenge3']['datasetUrl']).to eq AppConfig.challenge3[:dataset_url]
  end

  it "Should throw error if user is not admin" do
    context = { current_user: User.observer.first }
    query = <<~GRAPHQL
      mutation {
        updateAppConfig( input: { appConfigs: {} }) {
          appConfigs { challenge2 { totalWattUrl } }
        }
      }
    GRAPHQL

    expect{ Util.graphql_query(query) }.to raise_error "GraphQL: Need admin user"
  end
end
