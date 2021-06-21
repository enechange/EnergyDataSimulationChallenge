require './lib/plans'

class Simulator
  attr_reader :contract_amp, :power_usage, :plans

  def initialize(contract_amp, power_usage)
    @contract_amp = contract_amp
    @power_usage = power_usage
    @plans = Plans.new(contract_amp, power_usage)
  end

  def simulate
    plans.show_plans
  end
end
