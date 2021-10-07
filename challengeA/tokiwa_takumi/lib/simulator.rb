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
    @suggest_plans = plan_list.map{ |plan| plan.simulate_charge(@ampere, @monthly_amount_kwh) }
  end
end

a = Simulator.new(40, 300)
p a.simulate