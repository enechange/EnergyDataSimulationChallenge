# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TokyoGas do
  describe '東京ガスずっとも電気1の料金計算' do
    context '30A' do
      it '140kWh' do
        tokyogas = TokyoGas.new(30, 140)
        expect(tokyogas.tokyo_gas_plan).to eq 4171
      end

      it '141kWh' do
        tokyogas = TokyoGas.new(30, 141)
        expect(tokyogas.tokyo_gas_plan).to eq 4195
      end

      it '350kWh' do
        tokyogas = TokyoGas.new(30, 350)
        expect(tokyogas.tokyo_gas_plan).to eq 9186
      end

      it '351kWh' do
        tokyogas = TokyoGas.new(30, 351)
        expect(tokyogas.tokyo_gas_plan).to eq 9213
      end
    end

    context '40A' do
      it '140kWh' do
        tokyogas = TokyoGas.new(40, 140)
        expect(tokyogas.tokyo_gas_plan).to eq 4457
      end

      it '141kWh' do
        tokyogas = TokyoGas.new(40, 141)
        expect(tokyogas.tokyo_gas_plan).to eq 4481
      end

      it '350kWh' do
        tokyogas = TokyoGas.new(40, 350)
        expect(tokyogas.tokyo_gas_plan).to eq 9472
      end

      it '351kWh' do
        tokyogas = TokyoGas.new(40, 351)
        expect(tokyogas.tokyo_gas_plan).to eq 9499
      end
    end

    context '50A' do
      it '140kWh' do
        tokyogas = TokyoGas.new(50, 140)
        expect(tokyogas.tokyo_gas_plan).to eq 4743
      end

      it '141kWh' do
        tokyogas = TokyoGas.new(50, 141)
        expect(tokyogas.tokyo_gas_plan).to eq 4767
      end

      it '350kWh' do
        tokyogas = TokyoGas.new(50, 350)
        expect(tokyogas.tokyo_gas_plan).to eq 9758
      end

      it '351kWh' do
        tokyogas = TokyoGas.new(50, 351)
        expect(tokyogas.tokyo_gas_plan).to eq 9785
      end
    end

    context '60A' do
      it '140kWh' do
        tokyogas = TokyoGas.new(60, 140)
        expect(tokyogas.tokyo_gas_plan).to eq 5029
      end

      it '141kWh' do
        tokyogas = TokyoGas.new(60, 141)
        expect(tokyogas.tokyo_gas_plan).to eq 5053
      end

      it '350kWh' do
        tokyogas = TokyoGas.new(60, 350)
        expect(tokyogas.tokyo_gas_plan).to eq 10_044
      end

      it '351kWh' do
        tokyogas = TokyoGas.new(60, 351)
        expect(tokyogas.tokyo_gas_plan).to eq 10_071
      end
    end
  end
end
