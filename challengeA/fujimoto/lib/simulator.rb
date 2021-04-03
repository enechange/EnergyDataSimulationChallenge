require "./lib/importer/basic_plan_importer"
require "./lib/importer/label_importer"
require "./lib/importer/energy_plan_importer"

class Simulator

  def initialize(amps, kwh)
    @amps = amps
    @kwh = kwh
  end

  def simulate
    get_plan_data

    basic_plans = get_basic_plans(@basic_plans, @amps)
    energy_plans = get_energy_plans(@energy_plans, @kwh)
    plan_list = set_plan_list(basic_plans, energy_plans)

    return plan_list
  end

  private

  def get_plan_data                      
    @basic_plans = BasicPlanImporter.new("basic.csv").import
    @energy_plans = EnergyPlanImporter.new("energy.csv").import
  end

  def get_basic_plans(basic_plans, amps)
    basic_plans.filter{|plan| plan[:amps].to_f == amps }
  end

  def get_energy_plans(energy_plans, kwh)
    energy_plans.filter { |plan| plan[:kwh_min].to_f < kwh}
                .group_by(&:plan_id)
                .map { |k, v| v.max_by(&:kwh_min)}        
  end

  def set_plan_list(basic_plans, energy_plans)
    labels = LabelImporter.new("label.csv").import
    basic_plans.map(&:to_h)
    energy_plans.map(&:to_h)
    array = []
    labels.each do |label|
      basic_plan = basic_plans.find{|plan| plan.plan_id.to_i == label.id.to_i}
      next if basic_plan.nil?
      energy_plan = energy_plans.find{|plan| plan.plan_id.to_i == label.id.to_i}
      array.push({
        "provider_name": label.company_name,
        "plan_name": label.plan_name,
        "price": calculate_price(basic_plan, energy_plan)
      })
    end
    return array
  end

  def calculate_price(basic, energy)
    basic.price.to_f + energy.price.to_f * @kwh
  end

end