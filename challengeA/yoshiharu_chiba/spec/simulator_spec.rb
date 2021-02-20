# frozen_string_literal: true

require_relative '../lib/simulator'

RSpec.describe Simulator do
  describe 'プラン名とそのプラン料金を配列で返す' do
    context '10A ~ 20Aの場合' do
      it '10Aの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(10, 120)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '2671', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '3168', 'provider_name' => 'Looopでんき' }
        )
      end

      it '20Aの場合は2つの電力会社のプランを返す' do
        simulator = Simulator.new(20, 120)
        expect(simulator.simulate).to contain_exactly(
          { 'plan_name' => '従量電灯Bプラン', 'price' => '2957', 'provider_name' => '東京電力エナジーパートナー' },
          { 'plan_name' => 'おうちプラン', 'price' => '3168', 'provider_name' => 'Looopでんき' }
        )
      end
    end

    context '30A以上の場合' do
      it '30Aの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(30, 120)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '3243' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '3168' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '3698' }
        )
      end

      it '60Aの場合は3つの電力会社のプランを返す' do
        simulator = Simulator.new(60, 120)
        expect(simulator.simulate).to contain_exactly(
          { 'provider_name' => '東京電力エナジーパートナー', 'plan_name' => '従量電灯Bプラン', 'price' => '4101' },
          { 'provider_name' => 'Looopでんき', 'plan_name' => 'おうちプラン', 'price' => '3168' },
          { 'provider_name' => '東京ガス', 'plan_name' => 'ずっとも電気１プラン', 'price' => '4556' }
        )
      end
    end
  end
end
