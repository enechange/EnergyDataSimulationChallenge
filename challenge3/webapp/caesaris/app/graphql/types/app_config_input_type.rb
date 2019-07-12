module Types
  class GeneralInputType < Types::BaseInputObject
    argument :allow_graphiql, Boolean, required: false
    argument :show_demo_user, Boolean, required: false
  end

  class Challenge2InputType < Types::BaseInputObject
    argument :total_watt_url, String, required: false
  end

  class Challenge3InputType < Types::BaseInputObject
    argument :house_data_url, String, required: false
    argument :dataset_url, String, required: false
  end

  class AppConfigInputType < Types::BaseInputObject
    argument :general, GeneralInputType, required: false
    argument :challenge2, Challenge2InputType, required: false
    argument :challenge3, Challenge3InputType, required: false
  end
end
