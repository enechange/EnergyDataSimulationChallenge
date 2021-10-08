require_relative 'csv_plan'

class Simulator

  def initialize(ampere, monthly_amount_kwh)
    @ampere = ampere
    @monthly_amount_kwh = monthly_amount_kwh
    suggest_plan
  end

  def simulate
    @suggest_plans.flatten
  end

  private

  def suggest_plan
    @suggest_plans = []
    plan_list = CSVPlan.create_list_from_csv.map(&:convert_to_plan)
    @suggest_plans = plan_list.map{ |plan| simulate_charge(plan) }
  end

  def simulate_charge(plan)
    basic_charge = plan.basic_charge(@ampere)
    return if basic_charge.nil? ## 対応するアンペアなし

    price = basic_charge + plan.usage_charge(@monthly_amount_kwh)
    {
      "provider_name": plan.provider_name,
      "plan_name": plan.plan_name,
      "price": price
    }
  end
end
