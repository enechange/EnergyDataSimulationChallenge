# frozen_string_literal: true

require_relative '../simulator'
require 'factory_bot'
require 'factories/plan'

include FactoryBot::Syntax::Methods

RSpec.describe Plans do
  let(:tokyo_gas) { build(:tokyo_gas) }
  let(:tepco) { build(:tepco) }
  let(:looop_denki) { build(:looop_denki) }

  describe '#basic_price' do
    context '東京ガスの場合' do
      it '配列で返すこと' do
        plans = described_class.new([tokyo_gas])
        expect(plans.basic_price(30).class).to eq Array
      end

      it '正しい基本料金を返すこと' do
        plans = described_class.new([tokyo_gas])
        expect(plans.basic_price(30)[0].values[0]).to eq 858.0
        expect(plans.basic_price(40)[0].values[0]).to eq 1144.0
        expect(plans.basic_price(50)[0].values[0]).to eq 1430.0
        expect(plans.basic_price(60)[0].values[0]).to eq 1716.0
      end
    end

    context '東京電力エナジーパートナーの場合' do
      it '正しい基本料金を返すこと' do
        plans = described_class.new([tepco])
        expect(plans.basic_price(10)[0].values[0]).to eq 286.0
        expect(plans.basic_price(15)[0].values[0]).to eq 429.0
        expect(plans.basic_price(20)[0].values[0]).to eq 572.0
        expect(plans.basic_price(30)[0].values[0]).to eq 858.0
        expect(plans.basic_price(40)[0].values[0]).to eq 1144.0
        expect(plans.basic_price(50)[0].values[0]).to eq 1430.0
        expect(plans.basic_price(60)[0].values[0]).to eq 1716.0
      end
    end

    context 'Looopでんきの場合' do
      it '正しい基本料金を返すこと' do
        plans = described_class.new([looop_denki])
        expect(plans.basic_price(10)[0].values[0]).to eq 0
        expect(plans.basic_price(15)[0].values[0]).to eq 0
        expect(plans.basic_price(20)[0].values[0]).to eq 0
        expect(plans.basic_price(30)[0].values[0]).to eq 0
        expect(plans.basic_price(40)[0].values[0]).to eq 0
        expect(plans.basic_price(50)[0].values[0]).to eq 0
        expect(plans.basic_price(60)[0].values[0]).to eq 0
      end
    end

    context '2社の場合' do
      it '2社分のデータを返すこと' do
        plans = described_class.new([tokyo_gas, tepco])
        expect(plans.basic_price(30).count).to eq 2
      end
    end

    context '3社の場合' do
      it '3社分のデータを返すこと' do
        plans = described_class.new([tokyo_gas, tepco, looop_denki])
        expect(plans.basic_price(30).count).to eq 3
      end
    end
  end

  describe '#energy_price' do
    context '東京ガスの場合' do
      it '配列で返すこと' do
        plans = described_class.new([tokyo_gas])
        expect(plans.energy_price(100).class).to eq Array
      end

      it '正しい電力量料金を返すこと(1ヶ月の使用量が0 ~ 140kWh)' do
        plans = described_class.new([tokyo_gas])
        expect(plans.energy_price(0)[0].values[0]).to eq(0 * 23.67)
        expect(plans.energy_price(140)[0].values[0]).to eq(140 * 23.67)
      end

      it '正しい電力量料金を返すこと(1ヶ月の使用量が141 ~ 350kWh)' do
        plans = described_class.new([tokyo_gas])
        expect(plans.energy_price(141)[0].values[0]).to eq((141 - 140) * 23.88 + (140 * 23.67))
        expect(plans.energy_price(350)[0].values[0]).to eq((350 - 140) * 23.88 + (140 * 23.67))
      end

      it '正しい電力量料金を返すこと(1ヶ月の使用量が351kWh以上)' do
        plans = described_class.new([tokyo_gas])
        expect(plans.energy_price(351)[0].values[0]).to eq((351 - 350) * 26.41 + (350 - 140) * 23.88 + (140 * 23.67))
      end
    end

    context '東京電力エナジーパートナーの場合' do
      it '正しい電力量料金を返すこと(1ヶ月の使用量が0 ~ 120kWh)' do
        plans = described_class.new([tepco])
        expect(plans.energy_price(0)[0].values[0]).to eq(0 * 19.88)
        expect(plans.energy_price(120)[0].values[0]).to eq(120 * 19.88)
      end

      it '正しい電力量料金を返すこと(1ヶ月の使用量が121 ~ 300kWh)' do
        plans = described_class.new([tepco])
        expect(plans.energy_price(121)[0].values[0]).to eq((121 - 120) * 26.48 + (120 * 19.88))
        expect(plans.energy_price(300)[0].values[0]).to eq((300 - 120) * 26.48 + (120 * 19.88))
      end

      it '正しい電力量料金を返すこと(1ヶ月の使用量が301kWh以上)' do
        plans = described_class.new([tepco])
        expect(plans.energy_price(301)[0].values[0]).to eq((301 - 300) * 30.57 + (300 - 120) * 26.48 + (120 * 19.88))
      end
    end

    context 'Looopでんきの場合' do
      it '正しい電力量料金を返すこと' do
        plans = described_class.new([looop_denki])
        expect(plans.energy_price(100)[0].values[0]).to eq(100 * 26.40)
      end
    end

    context '2社の場合' do
      it '2社分のデータを返すこと' do
        plans = described_class.new([tokyo_gas, tepco])
        puts plans
        expect(plans.energy_price(30).count).to eq 2
      end
    end

    context '3社の場合' do
      it '3社分のデータを返すこと' do
        plans = described_class.new([tokyo_gas, tepco, looop_denki])
        expect(plans.energy_price(30).count).to eq 3
      end
    end
  end

  describe '#check' do
    context '引数に対応外の契約アンペアが送られてきた場合' do
      it '配列で返すこと' do
        plans = described_class.new([tokyo_gas])
        expect(plans.check(30).class).to eq Array
      end

      it '対象の会社のみを返すこと' do
        plans = described_class.new([tokyo_gas, tepco, looop_denki])
        pp plans.check(10)[0].provider_name
        expect(plans.check(30).count).to eq 3
        expect(plans.check(10).count).to eq 2
        expect(plans.check(10)[0].provider_name).to eq '東京電力エナジーパートナー'
        expect(plans.check(10)[1].provider_name).to eq 'Looopでんき'
        expect(plans.check(100).count).to eq 0
      end
    end
  end
end
