module Types
  class HouseholdEnergyRecordType < Types::BaseObject
    field :id, Int, null: false
    field :house_id, Int, null: false
    field :temperature, String, null: false
    field :daylight, String, null: false
    field :energy_production, String, null: false
    field :record_date, GraphQL::Types::ISO8601Date, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
