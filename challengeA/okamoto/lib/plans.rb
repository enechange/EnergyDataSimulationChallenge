require './lib/plan'
require 'json'
JSON_FILE_PATH = '../data/plans.json'

class Plans
  attr_reader :contract_amp, :power_usage, :plans

  def initialize(contract_amp, power_usage)
    @plans = load_plans
    @contract_amp = contract_amp
    @power_usage = power_usage
  end

  def show_plans
    plans.map { |plan| plan.available?(contract_amp)? plan.plan_with_price(contract_amp, power_usage) : nil }.compact
  end

  private

  def load_plans
    load_json.map {|data| Plan.new(
      name: data['name'],
      provider_name: data['provider_name'],
      basic_prices: data['basic_price'],
      pay_per_use_prices: data['pay_per_use_price']
    )}
  end

  def load_json
    json_file_path = File.expand_path(JSON_FILE_PATH, __dir__)
    JSON.load(File.open(json_file_path))
  end
end
