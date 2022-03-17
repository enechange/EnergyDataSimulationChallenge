# frozen_string_literal: true

require_relative '../calculator'
require_relative '../simulator'

class Company
  class LoopDenki
    NAME = 'Loopでんき'

    include Calculator

    private attr_reader :ampere, :kwh

    def initialize(ampere:, kwh:)
      @ampere = ampere
      @kwh   = kwh
      @plan_list = [OuchiPlan.new]
    end

    def simulate_list
      @plan_list.map do |plan|
        {
          provider_name: NAME,
          plan_name: plan.name,
          price: calculate(ampere:, kwh:, basic_charge: plan.basic_charge,
                           electricity_charge: plan.electricity_charge)
        }
      end
    end

    class OuchiPlan
      NAME = 'おうちプラン'

      ELECTRICITY_CHARGE = {
        1.. => '26.40'
      }.freeze

      attr_reader :name, :basic_charge, :electricity_charge

      def initialize
        @name = NAME
        @basic_charge = Simulator::CONSTRUCTABLE_AMPERES.each_with_object({}) do |key, hash|
          hash.store(key, '0.00')
        end
        @electricity_charge = ELECTRICITY_CHARGE
      end
    end

    private_constant :OuchiPlan
  end
end
