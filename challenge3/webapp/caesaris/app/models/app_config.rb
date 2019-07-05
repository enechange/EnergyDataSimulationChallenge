# RailsSettings Model
class AppConfig < RailsSettings::Base
  cache_prefix { "v1" }

  @field_keys = []

  def self.field(key, **opts)
    @field_keys << key.to_sym
    super(key, **opts)
  end

  def self.field_keys
    @field_keys
  end

  field :general, type: :hash, default: {
    # allow_graphiql: true
    allow_graphiql: Rails.env.development? || ENV['ALLOW_GRAPHIQL'].present?
  }

  field :challenge2, type: :hash, default: {
    total_watt_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge2/data/total_watt.csv",
  }

  field :challenge3, type: :hash, default: {
    house_data_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv",
    dataset_url: "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv",
  }

end
