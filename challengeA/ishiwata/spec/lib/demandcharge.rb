require 'spec_helper'

describe 'DemandCharge' do

  describe 'initialized' do

    it '入力データの取り出し 30' do
      demand_charge = DemandCharge.new(30)
      expect(demand_charge.ampere).to eq(30)
    end

    it '入力データの取り出し 0' do
      demand_charge = DemandCharge.new(0)
      expect(demand_charge.ampere).to eq(0)
    end

    it '入力データの取り出し 100' do
      demand_charge = DemandCharge.new(100)
      expect(demand_charge.ampere).to eq(100)
    end
  end

  describe 'tokyo_energy' do

    it '適切な価格の表示 0' do
      demand_charge = DemandCharge.new(0)

      expect(demand_charge.tokyo_demand).to eq(nil)
    end

    it '適切な価格の表示 10' do
      demand_charge = DemandCharge.new(10)

      expect(demand_charge.tokyo_demand).to eq(286)
    end
  end
end
