module Types
  class MutationType < Types::BaseObject
    field :update_app_config, mutation: Mutations::UpdateAppConfig

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
