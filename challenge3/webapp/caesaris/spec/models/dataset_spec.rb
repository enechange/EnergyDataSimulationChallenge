require 'rails_helper'

RSpec.describe Dataset, type: :model do
  before do
    @dataset = Dataset.first
  end

  it "Should find a Dataset" do
    expect(@dataset).to be_truthy
  end

  it "Should have relations on city" do
    expect(@dataset.city).to be_truthy
  end

  it "Should have relations on house" do
    expect(@dataset.house).to be_truthy
  end

  it "Should have `date_str` year-month string" do
    expect(@dataset.date_str).to be_truthy
    date = Date.parse("#{@dataset.date_str}-1")
    expect(date).to be_truthy
  end
end
