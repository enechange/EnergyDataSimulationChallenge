module Types
  class HouseOwnerType < Types::BaseObject
    field :id, Int, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
