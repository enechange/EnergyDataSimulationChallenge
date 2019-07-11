require "rails_helper"

RSpec.describe City, type: :model do
  before do
    @city = City.first
  end

  it "Should find a city" do
    expect(@city).to be_truthy
  end

  it "Should have relations on houses" do
    expect(@city.houses).to be_truthy
  end

  it "Should have relations on datasets" do
    expect(@city.datasets).to be_truthy
  end
end
