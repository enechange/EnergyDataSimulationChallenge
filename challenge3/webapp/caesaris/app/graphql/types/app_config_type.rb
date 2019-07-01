module Types
  class Challenge2Type < Types::BaseObject
    field :total_watt_url, String, null: false
  end

  class Challenge3Type < Types::BaseObject
    field :house_data_url, String, null: false
    field :dataset_url, String, null: false
  end

  class AppConfigType < Types::BaseObject
    field :challenge_2, Challenge2Type, null: false
    field :challenge_3, Challenge3Type, null: false
  end
end
