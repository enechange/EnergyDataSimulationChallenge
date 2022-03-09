require_relative '../../../lib/company/tokyo_gasu'

RSpec.describe do
  describe '#simulate_list' do
    subject { Company::TokyoGasu.new(ampere: ampere, watt: watt).simulate_list }

    context "契約不可なアンペア数の場合" do
      let(:watt) { 140 }
      let(:message) { "契約不可なアンペア数のため、合計値は表示されません。" }

      context "10A" do
        let(:ampere) { 10 }

        it do
          is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: message }]
        end
      end

      context "15A" do
        let(:ampere) { 10 }

        it do
          is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: message }]
        end
      end

      context "20A" do
        let(:ampere) { 10 }

        it do
          is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: message }]
        end
      end
    end

    context "契約可能なアンペア数の場合" do
      context "30A" do
        # 基本料金: 858.00円
        let(:ampere) { 30 }

        context "140kWh" do
          let(:watt) { 140 }

          it do
            # 基本料金: 858.00 + (140 * 23.67) = 4171.8
            is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 4171 }]
          end
        end

        context "141kWh" do
          let(:watt) { 141 }

          it do
            # 基本料金: 858.00 + (140 * 23.67) + (1 * 23.88) = 4195.68
            is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 4195 }]
          end
        end

        context "350kWh" do
          let(:watt) { 350 }

          it do
            # 基本料金: 858.00 + (140 * 23.67) + (210 * 23.88) = 9186.6
            is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 9186 }]
          end
        end

        context "351kWh" do
          let(:watt) { 351 }

          it do
            # 基本料金: 858.00 + (140 * 23.67) + (210 * 23.88) + (1 * 26.41) = 9213.01
            is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 9213 }]
          end
        end

        context "999_999_999_999kWh" do
          let(:watt) { 999_999_999_999 }

          it do
            # 基本料金: 858.00 + (140 * 23.67) + (210 * 23.88) + ((999,999,999,999 - 350) * 26.41) = 26409999999916.69
            is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 26409999999916 }]
          end
        end
      end

      context "40A, 400kWh" do
        let(:ampere) { 40 }
        let(:watt) { 400 }

        it do
          # 基本料金: 1144.00 + (140 * 23.67) + (210 * 23.88) + (50 * 26.41) = 10793.1
          is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 10793 }]
        end
      end

      context "50A, 400kWh" do
        let(:ampere) { 50 }
        let(:watt) { 400 }

        it do
          # 基本料金: 1430.00 + (140 * 23.67) + (210 * 23.88) + (50 * 26.41) = 11079.1
          is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 11079 }]
        end
      end

      context "60A, 400kWh" do
        let(:ampere) { 60 }
        let(:watt) { 400 }

        it do
          # 基本料金: 1716.00 + (140 * 23.67) + (210 * 23.88) + (50 * 26.41) = 11365.1
          is_expected.to eq [{ provider_name: "東京ガス", plan_name: "ずっとも電気１", price: 11365 }]
        end
      end
    end
  end
end
