require_relative '../lib/simulator.rb'

RSpec.describe Simulator do
  PROVIDERS = ['東京電力', 'looop', '東京ガス']
  TAX = 1.1
  
  describe '料金計算確認' do
    describe '東京電力' do
      it '使用量0の時は基本料金の半額' do
        prices = Contract.amps('東京電力').keys.map do |amp|
          Calculate.new('東京電力', amp, 0).price.floor
        end
        expect(prices).to eq [ 157, 235, 314, 471, 629, 786, 943 ]
      end

      it '使用量が80の時は基本料金+従量課金' do
        prices = Contract.amps('東京電力').keys.map do |amp|
          Calculate.new('東京電力', amp, 80).price.floor
        end
        expect(prices).to eq [ 2064, 2221, 2378, 2693, 3007, 3322, 3637 ]
      end

      it '使用量が121の時は基本料金+従量課金' do
        # 使用量が121以上の場合は120以上の電力量に対して120以下のそれと異なる係数で金額を計算する
        prices = Contract.amps('東京電力').keys.map do |amp|
          Calculate.new('東京電力', amp, 121).price.floor
        end
        expect(prices).to eq [ 2967, 3125, 3282, 3597, 3911, 4226, 4540 ]
      end

      it '使用量が301の時は基本料金＋従量課金' do
        # 使用量が301以上の場合は300以上の電力量に対して120以下及び300以下ののそれと異なる係数で金額を計算する
        prices = Contract.amps('東京電力').keys.map do |amp|
          Calculate.new('東京電力', amp, 301).price.floor
        end
        expect(prices).to eq [ 8215, 8372, 8530, 8844, 9159, 9473, 9788 ]
      end
    end

    describe 'looop' do
      it '使用量0の場合は0円' do
        prices = Contract.amps('looop').keys.map do |amp|
          Calculate.new('looop', amp, 0).price.floor
        end
        expect(prices).to eq [ 0, 0, 0, 0, 0, 0, 0 ]
      end

      it '使用量が80の時は従量課金' do
        prices = Contract.amps('looop').keys.map do |amp|
          Calculate.new('looop', amp, 80).price.floor
        end
        expect(prices).to eq [ 2323, 2323, 2323, 2323, 2323, 2323, 2323 ]
      end
    end

    describe '東京ガス' do
      it '使用量0の時は基本料金の半額' do
        prices = Contract.amps('東京ガス').keys.map do |amp|
          Calculate.new('東京ガス', amp, 0).price.floor
        end
        expect(prices).to eq [ 0, 0, 0, 0, 629, 786, 943 ]
      end

      it '使用量が80の時は基本料金+従量課金' do
        prices = Contract.amps('東京ガス').keys.map do |amp|
          Calculate.new('東京ガス', amp, 80).price.floor
        end
        expect(prices).to eq [ 2082, 2082, 2082, 2082, 3341, 3655, 3970 ]
      end

      it '使用量が141の時は基本料金+従量課金' do
        # 使用量が141以上の場合は140以上の電力量に対して140以下のそれと異なる係数で金額を計算する
        prices = Contract.amps('東京ガス').keys.map do |amp|
          Calculate.new('東京ガス', amp, 141).price.floor
        end
        expect(prices).to eq [ 3671, 3671, 3671, 3671, 4929, 5244, 5559 ]
      end

      it '使用量が351の時は基本料金＋従量課金' do
        # 使用量が351以上の場合は350以上の電力量に対して140以下及び350以下のそれと異なる係数で金額を計算する
        prices = Contract.amps('東京ガス').keys.map do |amp|
          Calculate.new('東京ガス', amp, 351).price.floor
        end
        expect(prices).to eq [ 9190, 9190, 9190, 9190, 10448, 10763, 11078 ]
      end
    end
  end
end