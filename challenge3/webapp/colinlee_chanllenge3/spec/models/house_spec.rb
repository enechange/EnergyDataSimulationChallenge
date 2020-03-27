# frozen_string_literal: true

require 'rails_helper'

RSpec.describe House, type: :model do
  let(:house) { create(:house, city: 'London') }
  let(:house2) { create(:house, city: 'Cambridge') }
  it { is_expected.to have_many(:energy_consumes) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_presence_of(:living_count) }

  it 'validates uniquess of uuid' do
    is_expected.to validate_uniqueness_of(:uuid)
  end

  before do
    create(:energy_consume, daylight: 30.0, house: house)
    create(:energy_consume, daylight: 40.0, house: house)
    create(:energy_consume, daylight: 50.3, house: house)
    create(:energy_consume, daylight: 51.0, house: house2)
    create(:energy_consume, daylight: 41.0, house: house2)
  end

  describe '#sum_daylights' do
    it { expect(house.sum_daylights).to eq(120.3) }
    it { expect(house2.sum_daylights).to eq(92.0) }
  end

  describe '.sum_house_daylights' do
    city = 'London'
    city2 = 'Cambridge'
    it { expect(described_class.sum_house_daylights(city)).to eq([120.3]) }
    it { expect(described_class.sum_house_daylights(city2)).to eq([92.0]) }
  end

  describe '.cities' do
    it { expect(described_class.cities).to eq(%w[Cambridge London]) }
  end
end
