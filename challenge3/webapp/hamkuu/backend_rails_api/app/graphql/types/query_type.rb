module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :house, HouseType, null: true do
      description 'Finds a house by its id'
      argument :house_id, Int, required: true
    end

    def house(house_id:)
      House.find_by_id(house_id)
    end

    field :houses, [Types::HouseType], null: false do
      description 'Gets all houses'
    end

    def houses
      House.all
    end

    field :house_owners, [Types::HouseOwnerType], null: false do
      description 'Gets all house owners'
    end

    def house_owners
      HouseOwner.all
    end

    field :household_energy_records, [Types::HouseholdEnergyRecordType], null: true do
      description 'Gets all energy records of a specific house'
      argument :house_id, Int, required: true
    end

    def household_energy_records(house_id:)
      HouseholdEnergyRecord.where(house_id: house_id)
    end
  end
end
