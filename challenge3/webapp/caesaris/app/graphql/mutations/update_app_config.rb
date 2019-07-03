module Mutations
  class UpdateAppConfig < BaseMutation
    description "Update application configs"
    # return fields
    field :app_configs, Types::AppConfigType, null: false

    # arguments
    argument :app_configs, Types::AppConfigInputType, required: true,
      description: "App configs, Partial update availble"

    # resolve method
    def resolve(app_configs:)
      Util.auth_user_graphql(context[:current_user])
      app_conf = app_configs.to_h
      app_conf.each do |fld, val|
        value_origin = AppConfig.try(fld)
        next if value_origin.nil? || val.blank?
        value_to_update = value_origin.is_a?(Hash) ?
          value_origin.deep_merge(val) : val
        method_name = "#{fld}="
        AppConfig.try(method_name, value_to_update)
      end
      { app_configs: AppConfig }
    end
  end
end
