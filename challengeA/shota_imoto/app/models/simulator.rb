class Simulator
  include ActiveModel::Model

  attr_accessor :current, :power
  def simulate
    plans = Plan.all.includes(:provider)
    simulation_results = []
    plans.each do |plan|
      basic_charge = plan.basic_charges.suitable_for_current(self.current)

      # if there are not basic charge relation of ampere, go next loop
      next unless basic_charge.kind_of?(BasicCharge)

      sum_usage_charge = plan.calculate_usage_charge(self.power_i)
      total_price = basic_charge.charge + sum_usage_charge

      simulation_results << SimulationResult.new(provider_name: plan.provider.name, plan_name: plan.name, price: total_price)
    end
    return simulation_results
  end

  def power_i
    self.power.to_i
  end
end
