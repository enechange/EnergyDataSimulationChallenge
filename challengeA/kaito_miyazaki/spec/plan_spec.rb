# frozen_string_literal: true

require './lib/plan'

RSpec.describe Plan do
  describe '#price' do
    subject { plan.price({ amp: amp, kwh: kwh }) }

    context '東京電力エナジーパートナーの従量電灯Bプランの場合' do
      let(:plan) { described_class.new('東京電力エナジーパートナー', PROVIDERS['東京電力エナジーパートナー'][0]['charge_rules']) }

      # 基本料金がNaNでない場合
      context '契約アンペア数が 30 かつ使用量が 110 の場合' do
        let(:amp) { 30 }
        let(:kwh) { 110 }
        it { is_expected.to eq((858 + 110 * 19.88).floor) }
      end
      # 基本料金がNaNの場合
      context '契約アンペア数が 100 かつ使用量が 100 の場合' do
        let(:amp) { 100 }
        let(:kwh) { 100 }
        it { is_expected.to be_nan }
      end
    end
  end
end
