module Types
  class HouseType < Types::BaseObject
    field :id, Int, null: false
    field :house_owner, Types::HouseOwnerType, null: false
    field :residents_count, Int, null: false
    field :has_children, Boolean, null: false
    field :city, String, null: false
    field :household_energy_records, [Types::HouseholdEnergyRecordType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
