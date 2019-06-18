module Types
  class DataSeriesType < Types::BaseObject
    field :date_labels, [String], null: false
    field :house_energy_prod, GraphQL::Types::JSON, null: false
    field :person_energy_prod, GraphQL::Types::JSON, null: false
    field :temperature, GraphQL::Types::JSON, null: false
    field :daylight, GraphQL::Types::JSON, null: false
  end
end