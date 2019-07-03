module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: false
    field :img_url, String, null: false
    field :roles, [String], null: false
    field :roles_code, Integer, null: false
    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false
  end
end
