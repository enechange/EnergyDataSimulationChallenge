# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportService::CityHouseDaylightService do
  describe 'report_data' do
    let(:house) { create(:house, city: 'London') }
    let(:house2) { create(:house, city: 'Cambridge') }

    before do
      create(:energy_consume, daylight: 30.0, house: house)
      create(:energy_consume, daylight: 40.0, house: house)
      create(:energy_consume, daylight: 50.3, house: house)
      create(:energy_consume, daylight: 51.0, house: house2)
      create(:energy_consume, daylight: 41.0, house: house2)
    end

    it do
      report_service = described_class.new
      expected_result = [
        {
          name:     house2.city,
          daylight: '92.0',
        },
        {
          name:     house.city,
          daylight: '120.3',
        },
      ]
      expect(report_service.report_data).to eq(expected_result)
    end
  end
end
