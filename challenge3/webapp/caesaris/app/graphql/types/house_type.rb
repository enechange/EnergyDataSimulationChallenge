module Types
  class HouseType < Types::BaseObject
    field :id, ID, null: false
    field :firstname, String, null: false
    field :lastname, String, null: false
    field :city_text, String, null: false
    field :num_of_people, Integer, null: false
    field :has_child, String, null: false
  end
end
