require 'rails_helper'

RSpec.describe 'DataSeriesService' do
  before do
    @data_series = DataSeriesService.new
  end

  it "Should return date_labels" do
    date_labels = @data_series.date_labels
    expect(date_labels.size).to be > 0
    expect(date_labels.first).to include '-'
  end

  it "Should return house_energy_prod" do
    city = City.first
    city_name = city.name
    date_str = city.datasets.first.date_str
    house_energy_prod = @data_series.house_energy_prod

    expect(house_energy_prod).to be_truthy
    expect(house_energy_prod[city_name]).to be_truthy
    expect(house_energy_prod[city_name][date_str]).to be_truthy
    expect(house_energy_prod[city_name][date_str].size).to eq 3
  end

  it "Should return person_energy_prod" do
    city = City.first
    city_name = city.name
    date_str = city.datasets.first.date_str
    person_energy_prod = @data_series.person_energy_prod

    expect(person_energy_prod).to be_truthy
    expect(person_energy_prod[city_name]).to be_truthy
    expect(person_energy_prod[city_name][date_str]).to be_truthy
    expect(person_energy_prod[city_name][date_str].size).to eq 3
  end

  it "Should return temperature" do
    expect(@data_series.temperature).to be_truthy
  end

  it "Should return daylight" do
    expect(@data_series.daylight).to be_truthy
  end
end