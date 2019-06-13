require 'rails_helper'

RSpec.describe House, type: :model do
  before do
    @house = House.first
  end

  it "Should find a house" do
    expect(@house).to be_truthy
  end

  it "Should have relations on city" do
    expect(@house.city).to be_truthy
  end

  it "Should have relations on datasets" do
    expect(@house.datasets).to be_truthy
  end

  it "Should have `has_child` as enum and boolean" do
    @house = House.where(has_child: true).first
    expect(@house.has_child).to eq "Yes"
    expect(@house.has_child_bool).to eq true
  end
end
