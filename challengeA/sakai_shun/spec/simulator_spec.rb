# frozen_string_literal: true

require_relative '../simulator'
require 'factory_bot'
require 'factories/plan'

include FactoryBot::Syntax::Methods

RSpec.describe Simulator do
  describe '#simulate' do
    context '契約アンペアが10Aの場合' do
      it '空の配列を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(10, 100, tokyo_gas)
        expect(simulator.simulate).to be_empty
      end
    end

    context '東京ガスの場合(契約アンペアが30A、1ヶ月の使用量が0 ~ 140kWh)' do
      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(30, 0, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq(858.0 + (0 * 23.67))
      end

      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(30, 140, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq(858.0 + (140 * 23.67))
      end
    end

    context '東京ガスの場合(契約アンペアが30A、1ヶ月の使用量が141 ~ 350kWh)' do
      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(30, 141, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq(858.0 + (141 - 140) * 23.88 + (140 * 23.67))
      end

      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(30, 350, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq(858.0 + (350 - 140) * 23.88 + (140 * 23.67))
      end
    end

    context '東京ガスの場合(契約アンペアが30A、1ヶ月の使用量が351kWh以上)' do
      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(30, 351, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq(858.0 + (351 - 350) * 26.41 + (350 - 140) * 23.88 + (140 * 23.67))
      end
    end

    context '東京ガスの場合(契約アンペアが40A、1ヶ月の使用量が100kWh)' do
      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        simulator = described_class.new(40, 100, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq(1144.0 + (100 * 23.67))
      end
    end

    context '東京電力エナジーの場合(契約アンペアが30A、1ヶ月の使用量が100kWh)' do
      it '正しい値を返すこと' do
        tepco = build(:tepco)
        simulator = described_class.new(30, 100, tepco)
        expect(simulator.simulate[0][:price]).to eq(858.0 + (100 * 19.88))
      end
    end

    context 'Looopでんきの場合(契約アンペアが30A、1ヶ月の使用量が100kWh)' do
      it '正しい値を返すこと' do
        looop_denki = build(:looop_denki)
        simulator = described_class.new(30, 100, looop_denki)
        expect(simulator.simulate[0][:price]).to eq(100 * 26.40)
      end
    end

    context '2社同時に計算する場合' do
      it '2社のデータを返すこと' do
        tokyo_gas = build(:tokyo_gas)
        tepco = build(:tepco)
        simulator = described_class.new(30, 100, tokyo_gas, tepco)
        expect(simulator.simulate.count).to eq 2
      end

      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        tepco = build(:tepco)
        simulator = described_class.new(30, 100, tokyo_gas, tepco)
        expect(simulator.simulate.select{_1[:provider_name] == '東京ガス'}[0][:price]).to eq 3225.0
        expect(simulator.simulate.select{_1[:provider_name] == '東京電力エナジーパートナー'}[0][:price]).to eq 2846.0
      end
    end

    context '3社同時に計算する場合' do
      it '3社のデータを返すこと' do
        tokyo_gas = build(:tokyo_gas)
        tepco = build(:tepco)
        looop_denki = build(:looop_denki)
        simulator = described_class.new(30, 100, tokyo_gas, tepco, looop_denki)
        expect(simulator.simulate.count).to eq 3
      end

      it '正しい値を返すこと' do
        tokyo_gas = build(:tokyo_gas)
        tepco = build(:tepco)
        looop_denki = build(:looop_denki)
        simulator = described_class.new(30, 100, tokyo_gas, tepco, looop_denki)
        expect(simulator.simulate.select{_1[:provider_name] == '東京ガス'}[0][:price]).to eq 3225.0
        expect(simulator.simulate.select{_1[:provider_name] == '東京電力エナジーパートナー'}[0][:price]).to eq 2846.0
        expect(simulator.simulate.select{_1[:provider_name] == 'Looopでんき'}[0][:price]).to eq 2640
      end
    end
  end
end
