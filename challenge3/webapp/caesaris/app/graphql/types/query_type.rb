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

    # TODO: Fix vulnerability of circular reference
    # Eg: `house(id: 1) { datasets { house { datasets { house { id } } } } }`
    field :house, Types::HouseType, null: true do
      description "Find a house by ID"
      argument :id, ID, required: true
    end
    def house(id:)
      House.find(id)
    end

    field :houses, [HouseType], null: true do
      argument :city, String, required: false
    end
    def houses(city: nil)
      if city.present?
        House.joins(:city).where(cities: {name: city}).order(:id)
      else
        House.all.order(:id)
      end
    end

  end
end
