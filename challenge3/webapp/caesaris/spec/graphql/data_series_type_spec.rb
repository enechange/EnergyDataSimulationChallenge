require 'rails_helper'

RSpec.describe 'GraphQL on DataSeriesType' do
  it "Should get date_labels" do
    query = "
      {
        dataSeries { dateLabels }
      }
    "
    data = Util.graphql_query(query)["dataSeries"]
    expect(data["dateLabels"].size).to be > 0
  end

  it "Should get house_energy_prod" do
    query = "
      {
        dataSeries { houseEnergyProd }
      }
    "
    city_name = City.last.name
    data = Util.graphql_query(query)["dataSeries"]
    expect(data["houseEnergyProd"][city_name].size).to be > 0
  end

  it "Should get person_energy_prod" do
    query = "
      {
        dataSeries { personEnergyProd }
      }
    "
    city_name = City.last.name
    data = Util.graphql_query(query)["dataSeries"]
    expect(data["personEnergyProd"][city_name].size).to be > 0
  end

  it "Should get daylight and temperature" do
    query = "
      {
        dataSeries { daylight, temperature }
      }
    "
    city_name = City.last.name
    data = Util.graphql_query(query)["dataSeries"]
    expect(data["daylight"][city_name].size).to be > 0
    expect(data["temperature"][city_name].size).to be > 0
  end
end
