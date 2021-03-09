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
                                    plan.usage_charge_list.to_a,
                                    plan.min_charge).to_s }
      end

      plans.each do |plan|
        puts plan
      end
    end
  end

  def calculate(basic_charge_list, usage_unit_charge_list, min_charge)
    result = (basic_charge(basic_charge_list) + usage_charge(usage_unit_charge_list)).floor
    result /= 2 if @usage.zero?
    result = min_charge if min_charge && result <= min_charge
    result
  end

  private

  def basic_charge(list)
    list.delete_at(0)
    list.find { |charge| charge[0] == @amps }[1]
  end

  def usage_charge(list)
    list.delete_at(0)
    list = list.map { |n| n.map(&:to_f) }
    price = 0
    list.each do |particular_case|
      if particular_case[0] < @usage && (@usage <= particular_case[1] || particular_case[1].zero?)
        price += particular_case[2] * (@usage - particular_case[0])
      elsif particular_case[1] < @usage && particular_case[1]
        price += particular_case[2] * particular_case[1]
      end
    end
    price
  end
end

simulator = Simulator.new(30, 100)
simulator.simulate
