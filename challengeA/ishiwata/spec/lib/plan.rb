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
    it '1つだけのプラン' do
      plan_list = [{provider_name: '東京電力', plan_name: '従量電灯B'}]
      ampere = 40
      usage = 240
      plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
      expect(plan.show_plan).to eq([{provider_name: '東京電力', plan_name: '従量電灯B', charge: 6707}])
    end

    it '2つのプラン' do
      plan_list = [{provider_name: '東京電力', plan_name: '従量電灯B'},
                {provider_name: 'Looopでんき', plan_name: 'おうちプラン'}]
      ampere = 40
      usage = 240
      plan = Plan.new(ampere: ampere, usage: usage, plans: plan_list)
      expect(plan.show_plan).to eq([{provider_name: '東京電力', plan_name: '従量電灯B', charge: 6707},
                {provider_name: 'Looopでんき', plan_name: 'おうちプラン', charge: 6336}])
    end
  end

end
