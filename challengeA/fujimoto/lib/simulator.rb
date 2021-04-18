# frozen_string_literal: true

require_relative 'importer'

class Simulator
  def initialize(amp, kwh)
    @amp = amp
    @kwh = kwh
    @all_basic_plans = Importer.new('basic.csv').import
    @all_energy_plans = Importer.new('energy.csv').import
    @providers = Importer.new('provider.csv').import
  end

  def simulate
    plans_with_price(basic_plans, energy_plans)
  end

  private

  def basic_plans
    @all_basic_plans.filter { |plan| plan[:amp] == @amp }
  end

  def energy_plans
    @all_energy_plans.filter { |plan| plan[:kwh_min] < @kwh }
                     .group_by { |plan| plan[:provider_id] }
  end

  def plans_with_price(basic_plans, energy_plans)
    basic_plans.map do |basic_plan|
      provider = @providers.find { |provider| provider[:id] == basic_plan[:provider_id] }
      energy_plan = energy_plans[provider[:id]]
      {
        provider_name: provider[:name],
        plan_name: provider[:plan_name],
        price: basic_plan[:price] + energy_plan_price(energy_plan)
      }
    end
  end

  def energy_plan_price(energy_plan)
    prereduced_energy_plan_values = energy_plan.sort_by { |plan| plan[:kwh_min] }
                                               .map do |plan|
      {
        kwh: plan[:kwh_min],
        price: plan[:price]
      }
    end.push({ kwh: @kwh })
    prereduced_energy_plan_values.each_cons(2)
                                 .map { |v| (v[1][:kwh] - v[0][:kwh]) * v[0][:price] }
                                 .reduce(:+)
  end
end
