# frozen_string_literal: true

require './lib/importer/basic_plan_importer'
require './lib/importer/provider_importer'
require './lib/importer/energy_plan_importer'
require 'active_support'
require 'active_support/core_ext'

class Simulator
  def initialize(amps, kwh)
    @amps = amps
    @kwh = kwh
  end

  def simulate
    all_basic_plans = BasicPlanImporter.new('basic.csv').import
    all_energy_plans = EnergyPlanImporter.new('energy.csv').import
    basic_plans = get_basic_plans(all_basic_plans)
    energy_plans = get_energy_plans(all_energy_plans)
    get_plan_list(basic_plans, energy_plans)
  end

  private

  def get_basic_plans(basic_plans)
    basic_plans.filter { |plan| plan[:amps].to_f == @amps }
  end

  def get_energy_plans(energy_plans)
    energy_plans.filter { |plan| plan[:kwh_min].to_f < @kwh }
                .group_by(&:provider_id)
                .map { |_k, v| v.max_by(&:kwh_min) }
  end

  def get_plan_list(basic_plans, energy_plans)
    providers = ProviderImporter.new('provider.csv').import
    basic_plans.map do |basic_plan|
      provider = providers.map(&:to_h).find { |provider| provider[:id] == basic_plan.provider_id }
      energy_plan = energy_plans.map(&:to_h).find { |energy_plan| energy_plan[:provider_id] == basic_plan.provider_id }
      {
        provider_name: provider[:name],
        plan_name: provider[:plan_name],
        price: calculate_price(basic_plan, energy_plan)
      }
    end
  end

  def calculate_price(basic, energy)
    (basic[:price].to_f + energy[:price].to_f * @kwh).round.to_s(:delimited)
  end
end
