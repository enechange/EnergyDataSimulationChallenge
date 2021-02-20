# frozen_string_literal: true

RSpec.describe Calculate do
  describe '東京ガスずっとも電気1の料金計算' do
    context '30A' do
      it '140kWh' do
        calculate = Calculate.new(30, 140)
        expect(calculate.tokyo_gas_plan).to eq '4171'
      end

      it '141kWh' do
        calculate = Calculate.new(30, 141)
        expect(calculate.tokyo_gas_plan).to eq '4195'
      end

      it '350kWh' do
        calculate = Calculate.new(30, 350)
        expect(calculate.tokyo_gas_plan).to eq '9186'
      end

      it '351kWh' do
        calculate = Calculate.new(30, 351)
        expect(calculate.tokyo_gas_plan).to eq '9213'
      end
    end

    context '40A' do
      it '140kWh' do
        calculate = Calculate.new(40, 140)
        expect(calculate.tokyo_gas_plan).to eq '4457'
      end

      it '141kWh' do
        calculate = Calculate.new(40, 141)
        expect(calculate.tokyo_gas_plan).to eq '4481'
      end

      it '350kWh' do
        calculate = Calculate.new(40, 350)
        expect(calculate.tokyo_gas_plan).to eq '9472'
      end

      it '351kWh' do
        calculate = Calculate.new(40, 351)
        expect(calculate.tokyo_gas_plan).to eq '9499'
      end
    end

    context '50A' do
      it '140kWh' do
        calculate = Calculate.new(50, 140)
        expect(calculate.tokyo_gas_plan).to eq '4743'
      end

      it '141kWh' do
        calculate = Calculate.new(50, 141)
        expect(calculate.tokyo_gas_plan).to eq '4767'
      end

      it '350kWh' do
        calculate = Calculate.new(50, 350)
        expect(calculate.tokyo_gas_plan).to eq '9758'
      end

      it '351kWh' do
        calculate = Calculate.new(50, 351)
        expect(calculate.tokyo_gas_plan).to eq '9785'
      end
    end

    context '60A' do
      it '140kWh' do
        calculate = Calculate.new(60, 140)
        expect(calculate.tokyo_gas_plan).to eq '5029'
      end

      it '141kWh' do
        calculate = Calculate.new(60, 141)
        expect(calculate.tokyo_gas_plan).to eq '5053'
      end

      it '350kWh' do
        calculate = Calculate.new(60, 350)
        expect(calculate.tokyo_gas_plan).to eq '10044'
      end

      it '351kWh' do
        calculate = Calculate.new(60, 351)
        expect(calculate.tokyo_gas_plan).to eq '10071'
      end
    end
  end
end
