require './simulate.rb'
require 'factory_bot'
require 'factories/plan.rb'

include FactoryBot::Syntax::Methods

RSpec.describe Simulator do
  describe "#simulate" do
    context "契約アンペアが10Aの場合" do
      it 'xxxx' do

      end

    end

    context "契約アンペアが30A、1ヶ月の使用量が0 ~ 140kWhの場合" do
      it '正しい値を返すこと' do
        tokyo_gas = build(:plan)
        simulator = Simulator.new(30, 0, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq (858.0 + (0 * 23.67))
      end

      it '正しい値を返すこと' do
        tokyo_gas = build(:plan)
        simulator = Simulator.new(30, 140, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq (858.0 + (140 * 23.67))
      end
    end

    context "契約アンペアが30A、1ヶ月の使用量が141 ~ 350kWhの場合" do
      it '正しい値を返すこと' do
        tokyo_gas = build(:plan)
        simulator = Simulator.new(30, 141, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq (858.0 + (141 * 23.88))
      end

      it '正しい値を返すこと' do
        tokyo_gas = build(:plan)
        simulator = Simulator.new(30, 350, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq (858.0 + (350 * 23.88))
      end
    end

    context "契約アンペアが30A、1ヶ月の使用量が351kWh以上の場合" do
      it '正しい値を返すこと' do
        tokyo_gas = build(:plan)
        simulator = Simulator.new(30, 351, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq (858.0 + (351 * 26.41))
      end
    end

    context "契約アンペアが40A、1ヶ月の使用量が100kWhの場合" do
      it '正しい値を返すこと' do
        tokyo_gas = build(:plan)
        simulator = Simulator.new(40, 100, tokyo_gas)
        expect(simulator.simulate[0][:price]).to eq (1144.0 + (100 * 23.67))
      end
    end
  end
end

# expect(result.select { |item| item.key?(tokyo_gas.name.to_sym) }[0][tokyo_gas.name.to_sym]).to eq tokyo_gas.basic_charge.select { |item| item[:ampere] == 30 }[0][:amount]
