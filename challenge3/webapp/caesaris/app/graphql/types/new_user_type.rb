module Types
  class NewUserType < Types::UpdateUserType
    argument :email, String, required: true
    argument :password, String, required: true
  end
end
