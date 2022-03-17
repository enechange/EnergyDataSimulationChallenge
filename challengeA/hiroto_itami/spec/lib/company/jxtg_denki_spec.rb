# frozen_string_literal: true

require_relative '../../../lib/company/jxtg_denki'

RSpec.describe do
  describe '#simulate_list' do
    subject { Company::JxtgDenki.new(ampere:, kwh:).simulate_list }

    context '契約不可なアンペア数の場合' do
      context '10A, 400kWh' do
        let(:ampere) { 10 }
        let(:kwh) { 400 }

        it do
          is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: '契約不可なアンペア数のため、合計値は表示されません。' }]
        end
      end

      context '15A, 400kWh' do
        let(:ampere) { 15 }
        let(:kwh) { 400 }

        it do
          is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: '契約不可なアンペア数のため、合計値は表示されません。' }]
        end
      end

      context '20A, 400kWh' do
        let(:ampere) { 20 }
        let(:kwh) { 400 }

        it do
          is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: '契約不可なアンペア数のため、合計値は表示されません。' }]
        end
      end
    end

    context '契約可能なアンペア数の場合' do
      context '30A' do
        let(:ampere) { 30 }

        context '120kWh' do
          let(:kwh) { 120 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) = 3243.6
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 3243 }]
          end
        end

        context '121kWh' do
          let(:kwh) { 121 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) + (1 * 26.48) = 3270.08
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 3270 }]
          end
        end

        context '300kWh' do
          let(:kwh) { 300 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) + (180 * 26.48) = 8010
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 8010 }]
          end
        end

        context '301kWh' do
          let(:kwh) { 301 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) + (180 * 26.48) + (1 * 25.08) = 8035.08
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 8035 }]
          end
        end

        context '600kWh' do
          let(:kwh) { 600 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) + (180 * 26.48) + (300 * 25.08) = 15534
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 15_534 }]
          end
        end

        context '601kWh' do
          let(:kwh) { 601 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) + (180 * 26.48) + (300 * 25.08) + (1 * 26.15) = 15560.15
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 15_560 }]
          end
        end

        context '999_999_999_999kWh' do
          let(:kwh) { 999_999_999_999 }

          it do
            # 基本料金: 858.00 + (120 * 19.88) + (180 * 26.48) + (300 * 25.08) + (999,999,999,399 * 26.15)
            #          = 26149999999817.85
            is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 26_149_999_999_817 }]
          end
        end
      end

      context '40A, 400kWh' do
        let(:ampere) { 40 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 1144.00 + (120 * 19.88) + (180 * 26.48) + (100 * 25.08) = 10804
          is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 10_804 }]
        end
      end

      context '50A, 400kWh' do
        let(:ampere) { 50 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 1430.00 + (120 * 19.88) + (180 * 26.48) + (100 * 25.08) = 11090
          is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 11_090 }]
        end
      end

      context '60A, 400kWh' do
        let(:ampere) { 60 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 1716.00 + (120 * 19.88) + (180 * 26.48) + (100 * 25.08) = 11376
          is_expected.to eq [{ provider_name: 'JXTGでんき', plan_name: 'たっぷりプラン', price: 11_376 }]
        end
      end
    end
  end
end
