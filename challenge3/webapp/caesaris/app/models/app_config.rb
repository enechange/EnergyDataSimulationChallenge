# RailsSettings Model
class AppConfig < RailsSettings::Base
  cache_prefix { "v1" }

  field :challenge_2, type: :hash, default: {
    total_watt_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge2/data/total_watt.csv",
  }

  field :challenge_3, type: :hash, default: {
    house_data_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv",
    dataset_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv",
  }
end
