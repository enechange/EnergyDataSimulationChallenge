require_relative '../calculator'

class Company
  class LoopDenki
    NAME = "Loopでんき"

    include Calculator

    private attr_reader :ampere, :watt

    def initialize(ampere:, watt:)
      @ampere = ampere
      @watt   = watt
      @plan_list = [OuchiPlan.new]
    end

    def simulate_list
      @plan_list.map do |plan|
        {
          provider_name: NAME,
          plan_name: plan.name,
          price: calculate(ampere: ampere, watt: watt, basic_charge: plan.basic_charge,  electricity_charge: plan.electricity_charge)
        }
      end
    end

    class OuchiPlan
      NAME = "おうちプラン"

      ELECTRICITY_CHARGE = {
        1.. => '26.40'
      }.freeze

      attr_reader :name, :basic_charge, :electricity_charge

      def initialize
        @name = NAME
        @basic_charge = (1..60).inject({}) { |hash, key| hash.store(key, '0.00'); hash }
        @electricity_charge = ELECTRICITY_CHARGE
      end
    end

    private_constant :OuchiPlan
  end
end
