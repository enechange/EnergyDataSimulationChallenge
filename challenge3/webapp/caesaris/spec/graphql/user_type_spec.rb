require "rails_helper"

RSpec.describe "GraphQL on User" do
  it "Should get all users" do
    query = <<~GRAPHQL
      {
        users {
          id, email, name, roles
        }
      }
    GRAPHQL

    context = { current_user: User.admin.first }
    data = Util.graphql_query(query, context: context)["users"]
    expect(data.size).to eq User.count
  end

  it "Should search user by id" do
    @user = User.last
    query = <<~GRAPHQL
      {
        users (q: { idEq: #{@user.id} }) {
          id, email, name, roles
        }
      }
    GRAPHQL

    context = { current_user: User.admin.first }
    data = Util.graphql_query(query, context: context)["users"][0]
    expect(data["id"]).to eq @user.id.to_s
    expect(data["email"]).to eq @user.email
    @user.roles.each do |role|
      expect(data["roles"]).to include role
    end
  end

  it "Should search user by email" do
    query = <<~GRAPHQL
      {
        users (q: { emailCont: "@", s: "id desc"}) {
          id, email, name, roles
        }
      }
    GRAPHQL

    @users = User.where(User.arel_table[:email].matches("%@%"))

    context = { current_user: User.admin.first }
    data = Util.graphql_query(query, context: context)["users"]
    expect(data.size).to eq @users.size
  end

  it "Should search user by role: admin" do
    role = "admin"
    query = <<~GRAPHQL
      {
        users (q: { hasRole: "#{role}"}) {
          id, roles
        }
      }
    GRAPHQL

    context = { current_user: User.admin.first }
    data = Util.graphql_query(query, context: context)["users"]
    expect(data.size).to eq User.admin.size
    data.each do |user|
      expect(user["roles"]).to include role
    end
  end

  it "Should search user by role: observer" do
    role = "observer"
    query = <<~GRAPHQL
      {
        users (q: { hasRole: "#{role}"}) {
          id, roles
        }
      }
    GRAPHQL

    context = { current_user: User.admin.first }
    data = Util.graphql_query(query, context: context)["users"]
    expect(data.size).to eq User.observer.size
    data.each do |user|
      expect(user["roles"]).to include role
    end
  end

  it "Should throw error if user is not admin" do
    query = <<~GRAPHQL
      {
        users (q: { idEq: 1 }) {
          id, email, name, roles
        }
      }
    GRAPHQL
    context = { current_user: User.observer.first }
    expect {
      Util.graphql_query(query, context: context)
    }.to raise_error "GraphQL: Need admin user"
  end
end
