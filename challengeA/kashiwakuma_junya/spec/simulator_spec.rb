require_relative '../lib/simulator.rb'

RSpec.describe Simulator do
  # それぞれの電力会社について契約電力が10,15,20,30,40,50,60の計算結果を配列で返している。
  def rspec_prices(provider, usage_kwh)
    prices = Contract.amp_price(provider).keys.map do |amp|
      Calculate.new(provider, amp, usage_kwh).price
    end
  end
  describe '料金計算確認' do
    # expectの比較先の配列は、資料や電力会社のサイトの計算式を用いてスプレッドシートで計算した結果である。
    # この配列は左から契約電力が10,15,20,30,40,50,60の場合それぞれの電気料金を示している。
    describe '東京電力' do
      let(:provider) { '東京電力' }
      it '使用量0の時は基本料金の半額' do
        expect(rspec_prices(provider, 0)).to eq [ 157, 235, 314, 471, 629, 786, 943 ]
      end

      it '使用量が80の時は基本料金+従量課金' do
        expect(rspec_prices(provider, 80)).to eq [ 2064, 2221, 2378, 2693, 3007, 3322, 3637 ]
      end

      it '使用量が121の時は基本料金+従量課金' do
        # 使用量が121以上の場合は120以上の電力量に対して120以下のそれと異なる係数で金額を計算する
        expect(rspec_prices(provider, 121)).to eq [ 2967, 3125, 3282, 3597, 3911, 4226, 4540 ]
      end

      it '使用量が301の時は基本料金＋従量課金' do
        # 使用量が301以上の場合は300以上の電力量に対して120以下及び300以下のそれと異なる係数で金額を計算する
        expect(rspec_prices(provider, 301)).to eq [ 8215, 8372, 8530, 8844, 9159, 9473, 9788 ]
      end
    end

    describe 'looop' do
      let(:provider) { 'looop' }
      it '使用量0の場合は0円' do
        expect(rspec_prices(provider, 0)).to eq [ 0, 0, 0, 0, 0, 0, 0 ]
      end

      it '使用量が80の時は従量課金' do
        expect(rspec_prices(provider, 80)).to eq [ 2323, 2323, 2323, 2323, 2323, 2323, 2323 ]
      end
    end

    describe '東京ガス' do
      let(:provider) { '東京ガス' }
      it '使用量0の時は基本料金の半額' do
        expect(rspec_prices(provider, 0)).to eq [ 0, 0, 0, 0, 629, 786, 943 ]
      end

      it '使用量が80の時は基本料金+従量課金' do
        expect(rspec_prices(provider, 80)).to eq [ 2082, 2082, 2082, 2082, 3341, 3655, 3970 ]
      end

      it '使用量が141の時は基本料金+従量課金' do
        # 使用量が141以上の場合は140以上の電力量に対して140以下のそれと異なる係数で金額を計算する
        expect(rspec_prices(provider, 141)).to eq [ 3671, 3671, 3671, 3671, 4929, 5244, 5559 ]
      end

      it '使用量が351の時は基本料金＋従量課金' do
        # 使用量が351以上の場合は350以上の電力量に対して140以下及び350以下のそれと異なる係数で金額を計算する
        expect(rspec_prices(provider, 351)).to eq [ 9190, 9190, 9190, 9190, 10448, 10763, 11078 ]
      end
    end
  end
end