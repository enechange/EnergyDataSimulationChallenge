# frozen_string_literal: true

require_relative '../../../lib/company/loop_denki'

RSpec.describe do
  describe '#simulate_list' do
    subject { Company::LoopDenki.new(ampere:, kwh:).simulate_list }

    context '契約可能なアンペア数の場合' do
      context '10A, 400kWh' do
        let(:ampere) { 10 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end

      context '15A, 400kWh' do
        let(:ampere) { 15 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end

      context '20A, 400kWh' do
        let(:ampere) { 20 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end

      context '30A, 400kWh' do
        let(:ampere) { 30 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end

      context '40A, 400kWh' do
        let(:ampere) { 40 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end

      context '50A, 400kWh' do
        let(:ampere) { 50 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end

      context '60A, 400kWh' do
        let(:ampere) { 60 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 0.00 + (400 * 26.40) = 10560
          is_expected.to eq [{ provider_name: 'Loopでんき', plan_name: 'おうちプラン', price: 10_560 }]
        end
      end
    end
  end
end
