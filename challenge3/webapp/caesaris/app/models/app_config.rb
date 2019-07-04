# RailsSettings Model
class AppConfig < RailsSettings::Base
  cache_prefix { "v1" }

  field :general, type: :hash, default: {
    # allow_graphiql: true
    allow_graphiql: Rails.env.development?
  }

  field :challenge2, type: :hash, default: {
    total_watt_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge2/data/total_watt.csv",
  }

  field :challenge3, type: :hash, default: {
    house_data_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv",
    dataset_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv",
  }

  def self.fields
    %i(general challenge2 challenge3)
  end
end
