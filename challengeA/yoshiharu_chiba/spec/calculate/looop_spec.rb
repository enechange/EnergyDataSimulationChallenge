# frozen_string_literal: true

require_relative '../../lib/calculate'

RSpec.describe Calculate do
  describe 'Looopでんきおうちプランの料金計算' do
    context '10A' do
      it '120kWh' do
        calculate = Calculate.new(10, 120)
        expect(calculate.looop_plan).to eq '3168'
      end

      it '301kWh' do
        calculate = Calculate.new(10, 301)
        expect(calculate.looop_plan).to eq '7946'
      end
    end

    context '60A' do
      it '120kWh' do
        calculate = Calculate.new(60, 120)
        expect(calculate.looop_plan).to eq '3168'
      end

      it '301kWh' do
        calculate = Calculate.new(60, 301)
        expect(calculate.looop_plan).to eq '7946'
      end
    end
  end
end
