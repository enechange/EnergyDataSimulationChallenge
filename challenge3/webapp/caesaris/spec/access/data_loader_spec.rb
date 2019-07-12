require "rails_helper"

RSpec.describe "DataLoader" do
  it "Should load house_data.csv from URL" do
    uri = "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv"
    DataLoader.load_houses(uri)
    house_num = House.all.size
    expect(house_num).to be > 0
  end

  it "Should create cities from cities" do
    DataLoader.load_cities
    city_num = City.all.size
    expect(city_num).to be > 0
  end

  it "Should add city_id to houses" do
    DataLoader.sync_cities_houses
    house_num = House.where(city_id: nil).size
    expect(house_num).to eq 0
  end

  it "Should load dataset_50.csv from URL" do
    uri = "https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv"
    DataLoader.load_dataset(uri)
    dataset_num = Dataset.all.size
    expect(dataset_num).to be > 0
  end
end
