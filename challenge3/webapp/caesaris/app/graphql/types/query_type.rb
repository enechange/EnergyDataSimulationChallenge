module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end

    field :house, Types::HouseType, null: true do
      description "Find a house by ID"
      argument :id, ID, required: true
    end
    def house(id:)
      House.find(id)
    end

  end
end
