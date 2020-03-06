require 'spec_helper'

describe 'Plan' do
  describe 'initialize' do
    it '正確に値を取得 provider_name' do
      plan = Plan.new({provider_name: '東京ガス', plan_name: '従量電灯B'})
      expect(plan.provider_name).to eq('東京ガス')
    end

    it '正確に値を取得 plan_name' do
      plan = Plan.new({provider_name: '東京ガス', plan_name: '従量電灯B'})
      expect(plan.plan_name).to eq('従量電灯B')
    end
  end
end
