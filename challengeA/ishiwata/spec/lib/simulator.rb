require 'spec_helper'

describe 'Simulator' do
  describe 'initialize' do
    it '入力データの取り出し ampere = 40' do
      simulator = Simulator.new(ampere: 40, usage: 240)
      expect(simulator.ampere).to eq(40)
    end

    it '入力データの取り出し usage = 240' do
      simulator = Simulator.new(ampere:40, usage:240)
      expect(simulator.usage).to eq(240)
    end
  end

  describe 'simulate' do

    context '適切な値を入力した場合' do

      it "契約アンペア : 0 A 電気使用量 : 100kWh" do
        simulator = Simulator.new(ampere:0, usage:100)
        expect(simulator.simulate).to eq(
                 [{provider_name: '東京電力', plan_name: '従量電灯B', error: 'このプランの料金をシミュレーションできませんでした'},
                  {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 2640 },
                  {provider_name: '東京ガス', plan_name: 'ずっとも電気1', error: 'このプランの料金をシミュレーションできませんでした' }])
      end

      it "契約アンペア : 10 A 電気使用量 : 100kWh" do
        simulator = Simulator.new(ampere:10, usage:100)
        expect(simulator.simulate).to eq(
                 [{provider_name: '東京電力', plan_name: '従量電灯B', charge: 2274},
                  {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 2640 },
                  {provider_name: '東京ガス', plan_name: 'ずっとも電気1', error: 'このプランの料金をシミュレーションできませんでした' }])
      end

      it "契約アンペア : 30 A 電気使用量 : 100kWh" do
        simulator = Simulator.new(ampere:30, usage:100)
        expect(simulator.simulate).to eq(
                 [{provider_name: '東京電力', plan_name: '従量電灯B', charge: 2846},
                  {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 2640 },
                  {provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 3225 }])
      end
    end

    context '適切な値を入力しなかった場合' do
      
      it "ampereが数字でなければNG" do
        simulator = Simulator.new(ampere: "アンペア",usage: 120)
        expect(simulator.simulate).to eq("契約アンペアと電気使用量は整数を入力してください。(例) 契約アンペア : 30 電気使用量 : 120")
      end

      it "usageが数字でなければNG" do
        simulator = Simulator.new(ampere: "40",usage: "使用量")
        expect(simulator.simulate).to eq("契約アンペアと電気使用量は整数を入力してください。(例) 契約アンペア : 30 電気使用量 : 120")
      end


      it "ampereが整数でなければNG" do
        simulator = Simulator.new(ampere: 10.0,usage: 120)
        expect(simulator.simulate).to eq("契約アンペアと電気使用量は整数を入力してください。(例) 契約アンペア : 30 電気使用量 : 120")
      end

      it "usageが整数でなければNG" do
        simulator = Simulator.new(ampere: 30,usage: 120.0)
        expect(simulator.simulate).to eq("契約アンペアと電気使用量は整数を入力してください。(例) 契約アンペア : 30 電気使用量 : 120")
      end
    end

  end
end
