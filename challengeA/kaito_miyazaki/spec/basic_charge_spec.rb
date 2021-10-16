# frozen_string_literal: true

require './lib/basic_charge'

RSpec.describe BasicCharge do
  describe '#calculate' do
    subject { basic_charge.calculate({ amp: amp, kwh: kwh }) }

    context '東京電力エナジーパートナーの従量電灯Bプランの場合' do
      let(:basic_charge) { described_class.new(PROVIDERS['東京電力エナジーパートナー'][0]['charge_rules']['basic_charge_rule']) }

      # 認められている契約アンペア数であり，使用量が0でない場合
      context '契約アンペア数が 30 かつ使用量が 100 の場合' do
        let(:amp) { 30 }
        let(:kwh) { 100 }
        it { is_expected.to eq 858 }
      end
      # 認められている契約アンペア数であり，使用量が0である場合
      context '契約アンペア数が 30 かつ使用量が 0 の場合' do
        let(:amp) { 30 }
        let(:kwh) { 0 }
        it { is_expected.to eq(858 / 2) }
      end
      # 認められていない契約アンペア数であり，使用量が0でない場合
      context '契約アンペア数が 100 かつ使用量が 100 の場合' do
        let(:amp) { 100 }
        let(:kwh) { 100 }
        it { is_expected.to be_nan }
      end
      # 認められていない契約アンペア数であり，使用量が0である場合
      context '契約アンペア数が 100 かつ使用量が 0 の場合' do
        let(:amp) { 100 }
        let(:kwh) { 0 }
        it { is_expected.to be_nan }
      end
    end
  end
end
