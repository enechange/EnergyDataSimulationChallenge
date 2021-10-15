# frozen_string_literal: true

require_relative 'plan'

# プロバイダークラス
class Provider
  attr_reader :name, :plans

  # plansの例：[ { 'plan_name' => 'PLAN_NAME_EXAMPLE',
  #               'charge_rules' => { 'basic_charge_rule' => { ... }, 'usage_charge_rule' => { ... } } }, ... ]
  def initialize(name, plans)
    @name = name
    @plans = plans.each_with_object([]) do |plan, array|
      array << Plan.new(plan['plan_name'], plan['charge_rules'])
    end
  end
end
