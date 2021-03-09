require_relative './plan'
require_relative './check'

class Simulator
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def simulate
    check = Check.new(@amps, @usage)
    if check.input_check == 1
      plans = []
      Plan::ALLPLANS.each do |plan|
        inculde_amps = plan.basic_charge_list
        next unless inculde_amps[:amps].include?(@amps)

        plans << { provider_name: plan.provider_name, plan_name: plan.plan_name,
                   price: calculate(plan.basic_charge_list.to_a,
                                    plan.usage_charge_list.to_a).to_s }
      end

      plans.each do |plan|
        puts plan
      end
    end
  end

  def calculate(basic_charge_list, usage_unit_charge_list)
    amount = @usage.round
    (basic_charge(basic_charge_list) + usage_unit_charge(usage_unit_charge_list) * amount).floor
  end

  private

  def basic_charge(list)
    list.delete_at(0)
    list.find { |charge| charge[0] == @amps }[1]
  end

  def usage_unit_charge(list)
    list.delete_at(0)
    if @usage.zero?
      @usage
    elsif list.last[0] >= @usage
      list.find { |charge| charge[0] < @usage && charge[1] >= @usage }[2]
    else
      list.last[2]
    end
  end
end

simulator = Simulator.new(10, 100)
simulator.simulate
