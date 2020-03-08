class Plan

  attr_reader :plans, :demand_charge, :energy_charge

  def initialize(args)
    @plans = args[:plans] || defaults
    @demand_charge = DemandCharge.new(args[:ampere])
    @energy_charge = EnergyCharge.new(args[:usage])
  end


  def show_plan
    plans.map{ |plan| plan.merge({ charge: sum_charge(plan) }) }
  end

  def sum_charge(plan)
    demand_charge.choose_plan(plan[:plan_name]) + energy_charge.choose_plan(plan[:plan_name])
  end

  def defaults
    default_plans = [{provider_name: '東京電力', plan_name: '従量電灯B'},
              {provider_name: 'Looopでんき', plan_name: 'おうちプラン'},
              {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}]
  end




end
