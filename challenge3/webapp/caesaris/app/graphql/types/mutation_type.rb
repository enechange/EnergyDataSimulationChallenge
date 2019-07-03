module Types
  class MutationType < Types::BaseObject
    field :new_user, mutation: Mutations::NewUser
    field :update_user, mutation: Mutations::UpdateUser
    field :update_app_config, mutation: Mutations::UpdateAppConfig
  end
end
