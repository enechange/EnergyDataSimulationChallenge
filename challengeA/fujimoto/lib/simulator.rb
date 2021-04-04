# frozen_string_literal: true

require_relative 'importer'
require 'active_support'
require 'active_support/core_ext'

class Simulator
  def initialize(amps, kwh)
    @amps = amps
    @kwh = kwh
  end

  def simulate
    all_basic_plans = Importer.new('basic.csv').import
    all_energy_plans = Importer.new('energy.csv').import
    providers = Importer.new('provider.csv').import
    basic_plans = get_basic_plans(all_basic_plans)
    energy_plans = get_energy_plans(all_energy_plans)
    get_plan_list(basic_plans, energy_plans, providers)
  end

  private

  def get_basic_plans(basic_plans)
    basic_plans.filter { |plan| plan[:amps] == @amps }
  end

  def get_energy_plans(energy_plans)
    energy_plans.filter { |plan| plan[:kwh_min] < @kwh }
                .group_by { |plan| plan[:provider_id] }
                .map { |_k, v| v.max_by { |plan| plan[:kwh_min] } }
  end

  def get_plan_list(basic_plans, energy_plans, providers)
    basic_plans.map do |basic_plan|
      provider = providers.find { |provider| provider[:id] == basic_plan[:provider_id] }
      energy_plan = energy_plans.find { |energy_plan| energy_plan[:provider_id] == basic_plan[:provider_id] }
      {
        provider_name: provider[:name],
        plan_name: provider[:plan_name],
        price: calculate_price(basic_plan, energy_plan)
      }
    end
  end

  def calculate_price(basic, energy)
    (basic[:price] + energy[:price] * @kwh).round.to_s(:delimited)
  end
end
