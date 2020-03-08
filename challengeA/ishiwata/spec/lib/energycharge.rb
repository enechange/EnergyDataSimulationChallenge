require 'spec_helper'

describe 'EnergyCharge' do
  describe 'initialize' do
    it '適切な値の入力' do
      energy_charge = EnergyCharge.new(200)
      expect(energy_charge.usage).to eq(200)
    end
  end

  describe 'tokyo_energy' do
    it '正確な値が出力されているか 0の時' do
      energy_charge = EnergyCharge.new(0)
      expect(energy_charge.tokyo_energy).to eq(0)
    end

    it '正確な値が出力されているか 300の時' do
      energy_charge = EnergyCharge.new(300)
      expect(energy_charge.tokyo_energy).to eq(7152)
    end
  end

  describe 'choose_plan' do

    it '引数通りの料金が出力されているか' do
      energy_charge = EnergyCharge.new(300)
      plan_name = '従量電灯B'
      expect(energy_charge.choose_plan(plan_name)).to eq(7152)
    end

    it '引数通りのプランの料金の表示 looop' do
      energy_charge = EnergyCharge.new(300)
      plan_name = 'おうちプラン'
      expect(energy_charge.choose_plan(plan_name)).to eq(7920)
    end
  end


end
