require 'rails_helper'

RSpec.describe 'Create and update user by GraphQL Mutation' do
  it "Create dummy users" do
    email = "admin-user-mutation@example.org"
    pass = "12345678"
    @admin_user = User.create({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ['admin']
    })
    email = "nomal-user-mutation@example.org"
    @normal_user = User.create({
      email: email, password: pass,
      password_confirmation: pass,
      roles: ['observer']
    })
  end

  context "Create user" do
    email = "new-user-mutation@example.org"
    role = "observer"
    query = <<~GRAPHQL
      mutation {
        newUser (
          input: {
            user: {
              email: "#{email}",
              password: "p@ssw0rd",
              roles: ["#{role}"]
            }
        }) {
          user {
            id, email, name, roles, imgUrl
          }
        }
      }
    GRAPHQL

    it "Should throw error if user is not admin" do
      context = { current_user: User.observer.first }
      expect {
        Util.graphql_query(query, context: context)
      }.to raise_error "GraphQL: Need admin user"
    end

    it "Should create new user" do
      context = { current_user: User.admin.first }
      data = nil
      expect {
        data = Util.graphql_query(query, context: context).dig('newUser', 'user')
      }.to change { User.count }.by(+1)
      expect(data["email"]).to eq email
      expect(data["roles"]).to include role
      expect(User.find_by(email: email)).to be_truthy
    end

    it "Should throw error if user email doubled" do
      context = { current_user: User.admin.first }
      expect {
        Util.graphql_query(query, context: context)
      }.to raise_error "Validation failed: Email has already been taken"
    end
  end

  context "Update user" do
    it "Should throw error if user is not admin" do
      @user = User.observer.last
      roles = %w(editor observer)
      query = <<~GRAPHQL
        mutation {
          updateUser (
            input: {
              id: #{@user.id}
              user: { roles: #{roles} }
          }) {
            user {
              id, email, name, roles
            }
          }
        }
      GRAPHQL

      context = { current_user: User.observer.first }
      expect {
        Util.graphql_query(query, context: context)
      }.to raise_error "GraphQL: Need admin user"
    end

    it "Should update user" do
      @user = User.observer.last
      roles = %w(editor observer)
      query = <<~GRAPHQL
        mutation {
          updateUser (
            input: {
              id: #{@user.id}
              user: { roles: #{roles} }
          }) {
            user {
              id, email, name, roles
            }
          }
        }
      GRAPHQL

      context = { current_user: User.admin.first }
      data = Util.graphql_query(query, context: context)
        .dig('updateUser', 'user')
      user_after = User.find(@user.id)
      expect(data["email"]).to eq user_after.email
      expect(data["name"]).to eq user_after.name
      user_after.roles.each do |role|
        expect(data["roles"]).to include role
      end
    end
  end
end
