# frozen_string_literal: true

require './lib/usage_charge'

RSpec.describe UsageCharge do
  describe '#calculate' do
    subject { usage_charge.calculate(kwh) }

    context '東京電力エナジーパートナーの従量電灯Bプランの場合' do
      let(:usage_charge) { described_class.new(PROVIDERS['東京電力エナジーパートナー'][0]['charge_rules']['usage_charge_rule']) }

      # 使用量 <= 0 である場合
      context '使用量が -100 の場合' do
        let(:kwh) { -100 }
        it { is_expected.to eq 0 }
      end
      context '使用量が 0 の場合' do
        let(:kwh) { 0 }
        it { is_expected.to eq 0 }
      end
      # 0 < 使用量 < 閾値 である場合
      context '使用量が 100 の場合' do
        let(:kwh) { 100 }
        it { is_expected.to eq(100 * 19.88) }
      end
      # 0 < 使用量 = 閾値 である場合
      context '使用量が 120 の場合' do
        let(:kwh) { 120 }
        it { is_expected.to eq(120 * 19.88) }
      end
      # 閾値 < 使用量 < 閾値 である場合
      context '使用量が 150 の場合' do
        let(:kwh) { 150 }
        it { is_expected.to eq(120 * 19.88 + 30 * 26.48) }
      end
      # 閾値 < 使用量 = 閾値 である場合
      context '使用量が 300 の場合' do
        let(:kwh) { 300 }
        it { is_expected.to eq(120 * 19.88 + 180 * 26.48) }
      end
      # 閾値 < 使用量 < 無限大 である場合
      context '使用量が 350 の場合' do
        let(:kwh) { 350 }
        it { is_expected.to eq(120 * 19.88 + 180 * 26.48 + 50 * 30.57) }
      end
    end

    context 'Looopでんきのおうちプランの場合' do
      let(:usage_charge) { described_class.new(PROVIDERS['Looopでんき'][0]['charge_rules']['usage_charge_rule']) }

      # 0 < 使用量 < 無限大 である場合
      context '使用量が 100 の場合' do
        let(:kwh) { 100 }
        it { is_expected.to eq(100 * 26.4) }
      end
    end
  end
end
