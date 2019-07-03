module Types
  class UpdateUserType < Types::BaseInputObject
    argument :name, String, required: false
    argument :img_url, String, required: false
    argument :roles, [String], required: false,
      description: "Roles in #{EasySettings.user_roles.keys}"
  end
end