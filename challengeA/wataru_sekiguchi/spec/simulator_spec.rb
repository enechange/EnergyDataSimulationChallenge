require 'spec_helper'

RSpec.describe Simulator do
  let(:answer)        { Simulator.new(residents, current_bills, consumption, amp) }
  let(:residents)     { 1 }
  let(:current_bills) { 1 }
  let(:consumption)   { 120 }
  let(:amp)           { 30 }

  describe 'Calculated total price' do
    context "of TEPCO's plan" do
      let(:rate) { { 120 => 19.88, 300 => 26.48, 9**9 => 30.57 } }
      let(:basic_price) { { 10 => 286, 15 => 429, 20 => 572, 30 => 858, 40 => 1144, 50 => 1430, 60 => 1716 } }
      subject { answer.calc[0][:total_price] }

      context 'with 10A' do
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 15A' do
        let(:amp) { 15 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 20A' do
        let(:amp) { 20 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 30A' do
        let(:amp) { 30 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 40A' do
        let(:amp) { 40 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 50A' do
        let(:amp) { 50 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 60A' do
        let(:amp) { 60 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 120kWh' do
        let(:consumption) { 120 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 121kWh' do
        let(:consumption)  { 121 }
        let(:higher_grade) { 300 }
        it { is_expected.to eq (basic_price[amp] + rate[higher_grade] * consumption).floor }
      end

      context 'with 300kWh' do
        let(:consumption) { 300 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 301kWh' do
        let(:consumption)  { 301 }
        let(:higher_grade) { 9**9 }
        it { is_expected.to eq (basic_price[amp] + rate[higher_grade] * consumption).floor }
      end
    end

    context "of Looop's plan" do
      let(:rate) { 26.40 }
      subject { answer.calc[1][:total_price] }

      context 'with any amperage' do
        let(:amp) { 60 }
        it { is_expected.to eq (rate * consumption).floor }
      end

      context 'with any consumption' do
        let(:consumption) { 350 }
        it { is_expected.to eq (rate * consumption).floor }
      end
    end

    context "of TOGAS's plan" do
      let(:consumption)   { 140 }
      let(:rate) { { 140 => 23.67, 350 => 23.88, 9**9 => 26.41 } }
      let(:basic_price) { { 30 => 858, 40 => 1144, 50 => 1430, 60 => 1716 } }
      subject { answer.calc[2][:total_price] }

      context 'with 30A' do
        let(:amp) { 30 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 40A' do
        let(:amp) { 40 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 50A' do
        let(:amp) { 50 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 60A' do
        let(:amp) { 60 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 140kWh' do
        let(:consumption) { 140 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 141kWh' do
        let(:consumption)  { 141 }
        let(:higher_grade) { 350 }
        it { is_expected.to eq (basic_price[amp] + rate[higher_grade] * consumption).floor }
      end

      context 'with 350kWh' do
        let(:consumption) { 350 }
        it { is_expected.to eq (basic_price[amp] + rate[consumption] * consumption).floor }
      end

      context 'with 351kWh' do
        let(:consumption)  { 351 }
        let(:higher_grade) { 9**9 }
        it { is_expected.to eq (basic_price[amp] + rate[higher_grade] * consumption).floor }
      end
    end
  end

  describe 'Output statements' do
    before do
      $stdout = StringIO.new
      answer.simulate
      @out = $stdout.string
    end
    subject { @out }

    it 'always show nessesary infomation' do
      is_expected.to include("現在のプラン：#{residents}人住まいでひと月#{current_bills}円（#{amp}A, #{consumption}kWh）")
      is_expected.to include('【最安値プラン】')
      is_expected.to include('【その他プラン】')
      is_expected.to include('東京電力エナジーパートナー')
      is_expected.to include('Looop')
      is_expected.to include('東京ガス')
    end

    context 'when the inputted amperage' do
      let(:guideline) { { 1 => 30, 2 => 30, 3 => 40, 4 => 50, 5 => 60 } }

      context 'might not be suitable' do
        let(:amp) { 10 }
        it 'show nessesary infomation' do
          is_expected.to include('【見直しのご提案】')
          is_expected.to include("#{residents}人住まいのあなたは#{guideline[residents]}Aがおすすめ！")
        end
      end

      context 'might be suitable' do
        let(:amp) { 30 }
        it 'show nessesary infomation' do
          is_expected.to_not include('【見直しのご提案】')
          is_expected.to_not include("#{residents}人住まいのあなたは#{guideline[residents]}Aがおすすめ！")
        end
      end
    end

    context 'when there is' do
      context 'no cheaper plan' do
        let(:current_bills) { 1 }
        it { is_expected.to include("現在ご契約中のプランが最安値（ひと月あたり#{current_bills}円）です！") }
      end

      context 'a more reasonable plan' do
        let(:current_bills) { 3000 }
        let(:consumption) { 50 }
        let(:amp) { 10 }
        it { is_expected.to_not include("現在ご契約中のプランが最安値（ひと月あたり#{current_bills}円）です！") }
      end
    end

    context "when 東京電力エナジーパートナー's plan" do
      let(:consumption) { 50 }
      let(:amp) { 10 }

      context 'is the cheapest' do
        let(:current_bills) { 3000 }
        it { is_expected.to include("【最安値プラン】\n 東京電力エナジーパートナーの従量電灯Bはひと月あたり") }
      end

      context 'is not the cheapest' do
        let(:current_bills) { 1 }
        it { is_expected.to_not include("【最安値プラン】\n 東京電力エナジーパートナーの従量電灯Bはひと月あたり") }
      end
    end

    context "when Looop's plan" do
      let(:consumption) { 10 }
      let(:amp) { 10 }

      context 'is the cheapest' do
        let(:current_bills) { 3000 }
        it { is_expected.to include("【最安値プラン】\n Looopでんきのおうちプランはひと月あたり") }
      end

      context 'is not the cheapest' do
        let(:current_bills) { 1 }
        it { is_expected.to_not include("【最安値プラン】\n Looopでんきのおうちプランはひと月あたり") }
      end
    end

    context "when 東京ガス's plan" do
      let(:consumption) { 350 }
      let(:amp) { 30 }

      context 'is the cheapest' do
        let(:current_bills) { 10_000 }
        it { is_expected.to include("【最安値プラン】\n 東京ガスのずっとも電気１はひと月あたり") }
      end

      context 'is not the cheapest' do
        let(:current_bills) { 1 }
        it { is_expected.to_not include("【最安値プラン】\n 東京ガスのずっとも電気１はひと月あたり") }
      end
    end
  end
end
