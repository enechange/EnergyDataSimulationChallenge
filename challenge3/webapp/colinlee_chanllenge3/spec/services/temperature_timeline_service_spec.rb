# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReportService::TemperatureTimelineService do
  describe 'report_data' do
    before do
      create(:energy_consume, year: 2018, month: 8, temperature: 22.0)
      create(:energy_consume, year: 2018, month: 8, temperature: 20.0)
      create(:energy_consume, year: 2017, month: 10, temperature: 18.0)
    end

    it do
      report_service = described_class.new
      expected_result = [
        {
          name:        '2017/10',
          temperature: '18.0',
        },
        {
          name:        '2018/8',
          temperature: '21.0',
        },
      ]
      expect(report_service.report_data).to eq(expected_result)
    end
  end
end
