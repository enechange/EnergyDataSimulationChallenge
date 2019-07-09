require 'rails_helper'
require 'devise/jwt/test_helpers'

headers = {
  'Accept' => 'application/json',
  'Content-Type' => 'application/json',
}

RSpec.describe 'Test GraphiQL Page Shown', type: :request do
  it "Create dummy users" do
    email = "admin-user-graphiql@example.org"
    pass = "12345678"
    @admin_user = User.create({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ['admin']
    })
  end

  it "Should show GraphiQL" do
    @user = User.admin.first
    AppConfig.general = {
      allow_graphiql: true,
    }
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, @user)

    get graphiql_rails_path(auth: URI.encode(auth_headers['Authorization']))
    expect(response).to be_successful
  end

  it "Should Reject GraphiQL if allow_graphiql: false" do
    @user = User.admin.first
    AppConfig.general = {
      allow_graphiql: false,
    }
    auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, @user)

    expect {
      get graphiql_rails_path(auth: URI.encode(auth_headers['Authorization']))
    }.to raise_error(ActionController::BadRequest)
  end

  it "Should Reject GraphiQL if no `auth` field" do
    expect {
      get graphiql_rails_path
    }.to raise_error(ActionController::BadRequest)
  end
end
