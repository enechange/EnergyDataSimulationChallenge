# frozen_string_literal: true

require './lib/basic_charge'

RSpec.describe BasicCharge do
  describe '#calculate' do
    subject { basic_charge.calculate(amp) }

    context '東京電力エナジーパートナーの従量電灯Bプランの場合' do
      let(:basic_charge) { described_class.new(PROVIDERS['東京電力エナジーパートナー'][0]['charge_rules']['basic_charge_rule']) }

      # 引数が認められている契約アンペア数である場合
      context '契約アンペア数が 30 の場合' do
        let(:amp) { 30 }
        it { is_expected.to eq 858 }
      end
      # 引数が認められていない契約アンペア数である場合
      context '契約アンペア数が 100 の場合' do
        let(:amp) { 100 }
        it { is_expected.to be_nan }
      end
    end
  end
end
