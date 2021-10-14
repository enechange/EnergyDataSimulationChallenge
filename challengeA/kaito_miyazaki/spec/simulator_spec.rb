# frozen_string_literal: true

require './lib/simulator'

RSpec.describe Simulator do
  describe '#simulate' do
    let(:simulator) { described_class.new(amp, kwh) }

    describe '戻り値の内容' do
      subject { simulator.simulate }

      # 基本料金がNaNでないプランについてのhashは戻り値に含まれること
      context '契約アンペア数が 30 かつ使用量が 100 の場合' do
        let(:amp) { 30 }
        let(:kwh) { 100 }
        it {
          is_expected.to include({ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: (858 + 100 * 19.88) })
        }
      end
      # 基本料金がNaNであるプランについてのhashは戻り値に含まれないこと
      context '契約アンペア数が 100 かつ使用量が 100 の場合' do
        let(:amp) { 100 }
        let(:kwh) { 100 }
        it { is_expected.not_to include({ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: Float::NAN }) }
      end
    end

    describe '戻り値の長さ' do
      subject { simulator.simulate.length }

      # 基本料金がNaNであるプランが存在しない場合
      context '契約アンペア数が 30 かつ使用量が 100 の場合' do
        let(:amp) { 30 }
        let(:kwh) { 100 }
        it { is_expected.to eq 4 }
      end
      # 基本料金がNaNであるプランが存在する場合
      context '契約アンペア数が 10 かつ使用量が 100 の場合' do
        let(:amp) { 10 }
        let(:kwh) { 100 }
        it { is_expected.to eq 2 }
      end
      context '契約アンペア数が 100 かつ使用量が 100 の場合' do
        let(:amp) { 100 }
        let(:kwh) { 100 }
        it { is_expected.to eq 0 }
      end
    end
  end
end
