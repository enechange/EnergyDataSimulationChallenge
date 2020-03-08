require 'spec_helper'

describe 'Simulator' do
  describe 'initialize' do
    it '値を取得 ampere' do
      simulator = Simulator.new(ampere: 40, usage: 240)
      expect(simulator.ampere).to eq(40)
    end

    it '値を取得 usage' do
      simulator = Simulator.new(ampere:40, usage:240)
      expect(simulator.usage).to eq(240)
    end
  end

  describe 'simulation' do
    it 'デフォルト (40A, 240kWh)' do
      simulator = Simulator.new(ampere:40, usage:240)
      expect(simulator.simulation).to eq(
               [{provider_name: '東京電力', plan_name: '従量電灯B', charge: 6707},
                {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 6336 },
                {provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 6845 }])
    end
  end
end
