class Plan

  HALFPLAN = ["従量電灯B", "ずっとも電気1"]
  MINPLAN = ["従量電灯B"]
  MINCHARGE = [235]

  attr_reader :plans, :demand_charge, :energy_charge

  def initialize(args)
    @plans = args[:plans] || defaults
    @demand_charge = DemandCharge.new(args[:ampere])
    @energy_charge = EnergyCharge.new(args[:usage])
  end


  def show_plan
    plans.map{ |plan| plan.merge( sum_charge(plan)) }
  end

  def sum_charge(plan)
    demand = demand_charge.choose_plan(plan[:plan_name])
    energy = energy_charge.choose_plan(plan[:plan_name])
    if demand.nil? || energy.nil?
      notice
    elsif half_plan?(energy, plan[:plan_name])
      if min_plan?(demand, plan[:plan_name])
        { charge: MINCHARGE[MINPLAN.index(plan[:plan_name])] }
      else
        { charge:  demand/2 }
      end
    else
      { charge:  demand + energy }
    end
  end

  def defaults
    default_plans = [{provider_name: '東京電力', plan_name: '従量電灯B'},
              {provider_name: 'Looopでんき', plan_name: 'おうちプラン'},
              {provider_name: '東京ガス', plan_name: 'ずっとも電気1'}]
  end

  def notice
    { error: 'このプランの料金をシミュレーションできませんでした'}
  end

  def half_plan?(energy_charge, plan)
    (HALFPLAN.include?(plan) && energy_charge == 0) ? true : false
  end

  def min_plan?(demand_charge, plan)
    (MINPLAN.include?(plan) && demand_charge/2 < MINCHARGE[MINPLAN.index(plan)]) ? true : false
  end









end
