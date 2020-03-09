require 'spec_helper'

describe 'Plan' do
  describe 'initialize' do
    it 'plans' do
      plan_list = [{provider_name: '東京電力', plan_name: '従量電灯B'},
                {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}]
      plans = Plan.new(ampere: 40, usage: 240, plans: plan_list)
      expect(plans.plans).to eq([{provider_name: '東京電力', plan_name: '従量電灯B'},
                {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}])
    end
  end

  describe 'show_plan' do

    context 'デフォルトプランの表示' do
      it '30A 50kWh' do
        ampere = 30
        usage = 50
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.show_plan).to eq([{provider_name: '東京電力', plan_name: '従量電灯B', charge: 1852},
                                      {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 1320 },
                                      {provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 2041 }])
      end

      it '40A 0kWh' do
        ampere = 40
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.show_plan).to eq([{provider_name: '東京電力', plan_name: '従量電灯B', charge: 1144/2},
                                      {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 0 },
                                      {provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 1144/2 }])
      end

      it '0A 50kWh' do
        ampere = 0
        usage = 50
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.show_plan).to eq([{provider_name: '東京電力', plan_name: '従量電灯B', error: 'このプランの料金をシミュレーションできませんでした'},
                                      {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 1320 },
                                      {provider_name: '東京ガス', plan_name: 'ずっとも電気1', error: 'このプランの料金をシミュレーションできませんでした' }])
      end

      it '20A 50kWh' do
        ampere = 20
        usage = 50
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.show_plan).to eq([{provider_name: '東京電力', plan_name: '従量電灯B', charge: 1566},
                                      {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 1320 },
                                      {provider_name: '東京ガス', plan_name: 'ずっとも電気1', error: 'このプランの料金をシミュレーションできませんでした' }])
      end
    end

    context '1つのプランを表示させる場合' do
      it '東京電力' do
        plan_list = [{provider_name: '東京電力', plan_name: '従量電灯B'}]
        ampere = 40
        usage = 240
        plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
        expect(plan.show_plan).to eq([{ provider_name: '東京電力', plan_name: '従量電灯B', charge: 6707 }])
      end

      it 'Looopでんき' do
        plan_list = [{ provider_name: 'Looopでんき', plan_name: 'おうちプラン' }]
        ampere = 40
        usage = 240
        plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
        expect(plan.show_plan).to eq([{ provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 6336 }])
      end

      it '東京ガス' do
        plan_list = [{ provider_name: '東京ガス', plan_name: 'ずっとも電気1' }]
        ampere = 40
        usage = 240
        plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
        expect(plan.show_plan).to eq([{ provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 6845 }])
      end
    end

    context '２つのプランを表示させる場合' do
      it '東京電力とLooopでんき' do
        plan_list = [{provider_name: '東京電力', plan_name: '従量電灯B'},
                  {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}]
        ampere = 40
        usage = 240
        plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
        expect(plan.show_plan).to eq([{ provider_name: '東京電力', plan_name: '従量電灯B', charge: 6707 },
                                      { provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 6336 }])
      end

      it '東京電力と東京ガス' do
        plan_list = [{provider_name: '東京電力', plan_name: '従量電灯B'},
                  {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}]
        ampere = 40
        usage = 240
        plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
        expect(plan.show_plan).to eq([{ provider_name: '東京電力', plan_name: '従量電灯B', charge: 6707 },
                                      { provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 6845 }])
      end

      it '東京ガスとLooopでんき' do
        plan_list = [{provider_name: '東京ガス', plan_name: 'ずっとも電気1'},
                  {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}]
        ampere = 40
        usage = 240
        plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
        expect(plan.show_plan).to eq([{ provider_name: '東京ガス', plan_name: 'ずっとも電気1', charge: 6845 },
                                      { provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 6336 }])
      end


    end



  end

  describe 'sum_charge' do

    context 'プランに契約アンペアが存在しない場合' do
      it '従量電灯B ampere = 5 usage = 100' do
        plan_item = {provider_name: '東京電力', plan_name: '従量電灯B'}
        ampere = 5
        usage = 100
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({ error: 'このプランの料金をシミュレーションできませんでした' })
      end

      it '従量電灯B ampere = 21 usage = 100' do
        plan_item = {provider_name: '東京電力', plan_name: '従量電灯B'}
        ampere = 21
        usage = 100
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({ error: 'このプランの料金をシミュレーションできませんでした' })
      end

      it 'ずっとも電気1 ampere = 5 usage = 100' do
        plan_item = {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}
        ampere = 5
        usage = 100
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({ error: 'このプランの料金をシミュレーションできませんでした' })
      end

      it 'ずっとも電気1 ampere = 31 usage = 100' do
        plan_item = {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}
        ampere = 31
        usage = 100
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({ error: 'このプランの料金をシミュレーションできませんでした' })
      end
    end
    context '最低金額になる場合' do
      it '従量電灯B ampere = 10 usage = 0' do
        plan_item = {provider_name: '東京電力', plan_name: '従量電灯B'}
        ampere = 10
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({charge: 235 })
      end

      it '従量電灯B ampere = 15 usage = 0' do
        plan_item = {provider_name: '東京電力', plan_name: '従量電灯B'}
        ampere = 15
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({charge: 235 })
      end
    end

    context '基本料金が半額になる場合' do
      it "従量電灯B ampere = 20 usage = 0" do
        plan_item = {provider_name: '東京電力', plan_name: '従量電灯B'}
        ampere = 20
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({charge: 572/2 })
      end

      it "従量電灯B ampere = 40 usage = 0" do
        plan_item = {provider_name: '東京電力', plan_name: '従量電灯B'}
        ampere = 40
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({charge: 1144/2 })
      end

      it "ずっとも電気1 ampere = 30 usage = 0" do
        plan_item = {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}
        ampere = 30
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({charge: 858/2 })
      end

      it "ずっとも電気1 ampere = 50 usage = 0" do
        plan_item = {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}
        ampere = 50
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({charge: 1430/2 })
      end
    end

    context '料金が半額にならない場合' do
      it "おうちプラン ampere = 30 usage = 0" do
        plan_item = {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}
        ampere = 30
        usage = 0
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({ charge: 0 })
      end

      it "おうちプラン ampere = 40 usage = 55" do
        plan_item = {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}
        ampere = 40
        usage = 55
        plan = Plan.new(ampere: ampere, usage: usage)
        expect(plan.sum_charge(plan_item)).to eq({ charge: 1452 })
      end
    end


  end

end
