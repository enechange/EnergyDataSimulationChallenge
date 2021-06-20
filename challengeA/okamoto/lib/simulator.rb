require 'json'
JSON_FILE_PATH = '../data/plans.json'

class Simulator
  attr_reader :contract_amp, :power_usage, :plans

  def initialize(contract_amp, power_usage)
    @contract_amp = contract_amp
    @power_usage = power_usage
    @plans = Plan.new(contract_amp, power_usage)
  end

  def simulate
    plans.show_plans
  end
end

class Plan
  attr_reader :contract_amp, :power_usage, :plans

  def initialize(contract_amp, power_usage)
    @plans = json_load
    @contract_amp = contract_amp
    @power_usage = power_usage
  end

  def show_plans
    plans.map { |plan| available?(plan)? plan_with_price(plan) : nil }.compact
  end

  private

  def json_load
    json_file_path = File.expand_path(JSON_FILE_PATH, __dir__)
    JSON.load(File.open(json_file_path))
  end

  def available?(plan)
    plan['basic_price'].find { |price| price['ampere'] == contract_amp }
  end

  def plan_with_price(plan)
    {
      provider_name: plan['provider_name'],
      plan_name: plan['name'],
      price: sum_price(plan)
    }
  end

  def sum_price(plan)
    (basic_price(plan) + pay_per_use_price(plan)).floor
  end

  def basic_price(plan)
    plan['basic_price'].find { |price| price['ampere'] == contract_amp }['price']
  end

  def pay_per_use_price(plan)
    sum = 0
    power_usage_before_stage = 0
    sorted_pay_per_use_price_lists(plan).each do |price_list|
      power_usage_current_stage = power_usage - price_list['min_kwh'] - power_usage_before_stage
      #丸め誤差が生じるため小数点第四位を四捨五入とする
      sum += (price_list['price_per_kwh'] * power_usage_current_stage).round(3)
      power_usage_before_stage += power_usage_current_stage
    end
    sum
  end

  def sorted_pay_per_use_price_lists(plan)
    pay_per_use_price_lists(plan).sort_by {|list| list['min_kwh']}.reverse
  end

  def pay_per_use_price_lists(plan)
    plan['pay_per_use_price'].select { |price| price['min_kwh'] <= power_usage }
  end
end

simulator = Simulator.new(30,600)
puts simulator.simulate
