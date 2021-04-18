# frozen_string_literal: true

require './lib/simulator'

RSpec.describe do
  describe 'シミュレーション結果がただしいこと' do
    it '東京電力エナジーパートナーの従量電灯Bプラン：15A, 100kWhの電力量で2,417円' do
      simulator = Simulator.new(15, 100)
      plan_a = simulator.simulate.find do |plan|
        plan[:provider_name] == '東京電力エナジーパートナー' && plan[:plan_name] == '従量電灯B'
      end

      expect(plan_a[:price]).to eq 2417
    end

    it '東京ガスのずっとも電気1プラン：30A, 200kWhの電力量で5,604.6円' do
      simulator = Simulator.new(30, 200)
      plan_b = simulator.simulate.find do |plan|
        plan[:provider_name] == '東京ガス' && plan[:plan_name] == 'ずっとも電気1'
      end
      expect(plan_b[:price]).to eq 5604.6
    end

    it 'Looopでんきのおうちプラン：20A, 150kWhの電力量で3,960円' do
      simulator = Simulator.new(20, 150)
      plan_c = simulator.simulate.find do |plan|
        plan[:provider_name] == 'Looopでんき' && plan[:plan_name] == 'おうちプラン'
      end
      expect(plan_c[:price]).to eq 3960
    end

    it 'JXTGでんきの従量電灯Bたっぷりプラン：50A, 400kWhの電力量で11,090円' do
      simulator = Simulator.new(50, 400)
      plan_d = simulator.simulate.find do |plan|
        plan[:provider_name] == 'JXTGでんき' && plan[:plan_name] == '従量電灯B たっぷりプラン'
      end
      expect(plan_d[:price]).to eq 11_090.0
    end
  end
end
