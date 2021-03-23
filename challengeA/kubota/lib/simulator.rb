# frozen_string_literal: true

require "yaml"
require "active_model"

class Simulator
  include ActiveModel::Model

  PLANS = YAML.load_file("./plans.yaml")
  CONTRACT_AMPS = [10, 15, 20, 30, 40, 50, 60]

  attr_accessor :contract_ampere, :electric_energy_per_month

  validates :contract_ampere, inclusion: { in: CONTRACT_AMPS }
  validates :electric_energy_per_month, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def initialize(contract_ampere, electric_energy_per_month)
    @contract_ampere = contract_ampere
    @electric_energy_per_month = electric_energy_per_month
  end

  def simulate
    return "無効な契約アンペアまたは電力量です。" if invalid?

    PLANS.map do |plan|
      {
        provider_name: plan.first,
        plan_name: plan.last["plan_name"],
        price: price(plan),
      }
    end
  end

  private
    def price(plan)
      return "対象外の契約電流のため計算できません。" unless plan.last["basic_charges"].keys.include?(@contract_ampere)
      (basic_charge(plan.last["basic_charges"]) + commodity_charge(plan.last["commodity_charges"])).floor
    end

    def basic_charge(basic_charges)
      return 0 if basic_charges == nil

      basic_charges[@contract_ampere]
    end

    def commodity_charge(commodity_charges)
      thresholds = commodity_charges["thresholds"]
      charges = commodity_charges["charges"]

      if commodity_charges["thresholds"] == nil
        return @electric_energy_per_month * commodity_charges["charges"]
      end

      first_threshold = thresholds["first"]
      second_threshold = thresholds["second"]

      if @electric_energy_per_month <= first_threshold
        @electric_energy_per_month * charges["first"]
      elsif @electric_energy_per_month > first_threshold && @electric_energy_per_month <= second_threshold
        first_threshold * charges["first"] + (@electric_energy_per_month - first_threshold) * charges["second"]
      else
        first_threshold * charges["first"] + second_threshold * charges["second"] + (@electric_energy_per_month - second_threshold) * charges["third"]
      end
    end
end
