module Types
  class CityType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :houses, [Types::HouseType], null: true
    field :datasets, [Types::DatasetType], null: true
  end
end
