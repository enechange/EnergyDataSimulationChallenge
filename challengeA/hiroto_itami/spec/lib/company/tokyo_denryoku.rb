# frozen_string_literal: true

require_relative '../../../lib/company/tokyo_denryoku'

RSpec.describe do
  describe '#simulate_list' do
    subject { Company::TokyoDenryoku.new(ampere:, kwh:).simulate_list }

    context '契約可能なアンペア数の場合' do
      context '10A' do
        let(:ampere) { 10 }

        context '120kWh' do
          let(:kwh) { 120 }

          it do
            # 基本料金: 286.00 + (120 * 19.88) = 2671.6
            is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 2671 }]
          end
        end

        context '121kWh' do
          let(:kwh) { 121 }

          it do
            # 基本料金: 286.00 + (120 * 19.88) + (1 * 26.48) = 2698.08
            is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 2698 }]
          end
        end

        context '300kWh' do
          let(:kwh) { 300 }

          it do
            # 基本料金: 286.00 + (120 * 19.88) + (180 * 26.48) = 7438
            is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 7438 }]
          end
        end

        context '301kWh' do
          let(:kwh) { 301 }

          it do
            # 基本料金: 286.00 + (120 * 19.88) + (180 * 26.48) + (1 * 30.57) = 7468
            is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 7468 }]
          end
        end

        context '999_999_999_999kWh' do
          let(:kwh) { 999_999_999_999 }

          it do
            # 基本料金: 286.00 + (120 * 19.88) + (180 * 26.48) + (999_999_999_699 * 30.57) = 30569999998236.43
            is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 30_569_999_998_236 }]
          end
        end
      end

      context '15A, 400kWh' do
        let(:ampere) { 15 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 429.00 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57) = 10638
          is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 10_638 }]
        end
      end

      context '20A, 400kWh' do
        let(:ampere) { 20 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 572.00 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57) = 10781
          is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 10_781 }]
        end
      end

      context '30A, 400kWh' do
        let(:ampere) { 30 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 858.00 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57) = 11067
          is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 11_067 }]
        end
      end

      context '40A, 400kWh' do
        let(:ampere) { 40 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 1144.00 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57) = 11353
          is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 11_353 }]
        end
      end

      context '50A, 400kWh' do
        let(:ampere) { 50 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 1430.00 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57) = 11639
          is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 11_639 }]
        end
      end

      context '60A, 400kWh' do
        let(:ampere) { 60 }
        let(:kwh) { 400 }

        it do
          # 基本料金: 1716.00 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57) = 11925
          is_expected.to eq [{ provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 11_925 }]
        end
      end
    end
  end
end
