class Simulator
  include ActiveModel::Model

  attr_accessor :current, :power
  def simulate
    plans = Plan.all.includes(:provider, :basic_charges, :usage_charges)
    simulation_results = []
    plans.each do |plan|

      # find suitable basic charge for current
      # FIXME: Make me readable!! This code confuses developers, "what's happen??"
      basic_charge = plan.basic_charges.find{|basic_charge| basic_charge.current == self.current_i}

      # if there are not basic charge relation of ampere, go next loop
      next unless basic_charge.kind_of?(BasicCharge)

      sum_usage_charge = plan.calculate_usage_charge(self.power_i)
      total_price = total_price(basic_charge.charge, sum_usage_charge)

      simulation_results << SimulationResult.new(provider_name: plan.provider.name, plan_name: plan.name, price: total_price)
    end
    return simulation_results
  end

  def power_i
    self.power.to_i
  end

  def current_i
    self.current.to_i
  end

  def total_price(basic_charge, sum_usage_charge)
    if sum_usage_charge == 0
      # when use 0 kWh power, we must pay only half price of basic_charge.
      (basic_charge/2).floor
    else
      (basic_charge + sum_usage_charge).floor
    end
  end
end
