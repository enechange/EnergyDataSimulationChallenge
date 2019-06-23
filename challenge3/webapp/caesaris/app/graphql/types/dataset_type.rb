module Types
  class DatasetType < Types::BaseObject
    field :id, ID, null: false
    field :label, Integer, null: false
    # field :house_id, Integer, null: false
    field :house, Types::HouseType, null: false
    field :city, Types::CityType, null: false
    field :year, Integer, null: false
    field :month, Integer, null: false
    field :date_str, String, null: false
    field :temperature, Float, null: false
    field :daylight, Float, null: false
    field :energy_production, Integer, null: false
  end
end
