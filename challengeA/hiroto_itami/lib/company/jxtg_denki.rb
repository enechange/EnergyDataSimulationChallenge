# frozen_string_literal: true

require_relative '../calculator'

class Company
  class JxtgDenki
    NAME = 'JXTGでんき'

    include Calculator

    private attr_reader :ampere, :kwh

    def initialize(ampere:, kwh:)
      @ampere = ampere
      @kwh   = kwh
      @plan_list = [TappuriPlan.new]
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

    class TappuriPlan
      NAME = 'たっぷりプラン'

      BASIC_CHARGE = {
        30 => '858.00',
        40 => '1144.00',
        50 => '1430.00',
        60 => '1716.80'
      }.freeze

      ELECTRICITY_CHARGE = {
        1..120 => '19.88',
        121..300 => '26.48',
        301..600 => '25.08',
        601.. => '26.15'
      }.freeze

      attr_reader :name, :basic_charge, :electricity_charge

      def initialize
        @name = NAME
        @basic_charge = BASIC_CHARGE
        @electricity_charge = ELECTRICITY_CHARGE
      end
    end

    private_constant :TappuriPlan
  end
end
