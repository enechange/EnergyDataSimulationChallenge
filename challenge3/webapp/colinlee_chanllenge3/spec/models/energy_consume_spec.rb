# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnergyConsume, type: :model do
  it { is_expected.to belong_to(:house) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_presence_of(:year) }
  it { is_expected.to validate_presence_of(:month) }
  it { is_expected.to validate_presence_of(:temperature) }
  it { is_expected.to validate_presence_of(:daylight) }
  it { is_expected.to validate_presence_of(:energy_production) }

  it 'validates uniquess of uuid' do
    create(:energy_consume)
    is_expected.to validate_uniqueness_of(:uuid)
  end

  describe '.average_temperature_timeline' do
    before do
      create(:energy_consume, year: 2018, month: 8, temperature: 22.0)
      create(:energy_consume, year: 2018, month: 8, temperature: 20.0)
      create(:energy_consume, year: 2017, month: 10, temperature: 18.0)
    end

    it { expect(described_class.average_temperature_timeline).to eq([[2017, 10, 18.0], [2018, 8, 21.0]]) }
  end
end
