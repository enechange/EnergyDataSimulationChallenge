require 'json'

class Murasaki::Simulator
  attr_reader :ampere, :kwh

  # @param ampere [Integer] 契約アンペア
  # @param kwh [Integer] １ヶ月の使用量（kWh）
  def initialize(ampere, kwh)
    @ampere = ampere
    @kwh = kwh
  end

  def simulate
    plans = Murasaki::ServicePlan.availables(ampere, kwh)
    return [] if plans.empty?

    plans.map do |plan|
      {
        plan_name: plan[:name],
        price: get_amount(kwh, plan),
        provider_name: plan[:provider_name]
      }
    end
  end

  def get_amount(kwh, plan)
    plan[:plan][:amount] + sum_up_each_tier_amount(kwh, plan[:monthly_tier])
  end

  def sum_up_each_tier_amount(kwh, monthly_tier)
    total = 0
    monthly_tier.each do |tier|
      range = Range.new(tier[:range][:from_kwh], tier[:range][:to_kwh])

      if range.cover?(kwh)
        total += tier[:cost_per_kwh] * (kwh - tier[:range][:from_kwh].to_i)
      elsif !tier[:range][:to_kwh].nil? && kwh > tier[:range][:to_kwh]
        total += tier[:cost_per_kwh] * (tier[:range][:to_kwh] - tier[:range][:from_kwh].to_i)
      end
    end

    total
  end
end
