module Mutations
  class UpdateAppConfig < BaseMutation
    # return fields
    field :app_configs, Types::AppConfigType, null: false

    # arguments
    argument :app_configs, Types::AppConfigInputType, required: true

    # resolve method
    def resolve(app_configs:)
      app_conf = app_configs.to_h
      app_conf.each do |fld, val|
        method_name = "#{fld}="
        AppConfig.try(method_name, val) if val.present?
      end
      { app_configs: AppConfig }
    end
  end
end
