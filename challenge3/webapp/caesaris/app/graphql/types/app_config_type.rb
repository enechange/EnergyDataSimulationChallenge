module Types
  class GeneralType < Types::BaseObject
    field :allow_graphiql, Boolean, null: false
    field :show_demo_user, Boolean, null: false
  end

  class Challenge2Type < Types::BaseObject
    field :total_watt_url, String, null: false
  end

  class Challenge3Type < Types::BaseObject
    field :house_data_url, String, null: false
    field :dataset_url, String, null: false
  end

  class AppConfigType < Types::BaseObject
    field :general, GeneralType, null: false
    field :challenge2, Challenge2Type, null: false
    field :challenge3, Challenge3Type, null: false
    field :field_keys, [String], null: false
  end
end
