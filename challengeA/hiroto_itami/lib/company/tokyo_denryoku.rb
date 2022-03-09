require_relative '../calculator'

class Company
  class TokyoDenryoku
    NAME = "東京電力エナジーパートナー"

    include Calculator

    private attr_reader :ampere, :watt

    def initialize(ampere:, watt:)
      @ampere = ampere
      @watt   = watt
      @plan_list = [JuuryouDentouB.new]
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

    class JuuryouDentouB
      NAME = "従量電灯B"

      BASIC_CHARGE = {
        10 => '286.00',
        15 => '429.00',
        20 => '572.00',
        30 => '858.00',
        40 => '1144.00',
        50 => '1430.00',
        60 => '1716.00'
      }.freeze

      ELECTRICITY_CHARGE = {
        1..120 => '19.88',
        121..300 => '26.48',
        301.. => '30.57'
      }.freeze

      attr_reader :name, :basic_charge, :electricity_charge

      def initialize
        @name = NAME
        @basic_charge = BASIC_CHARGE
        @electricity_charge = ELECTRICITY_CHARGE
      end
    end

    private_constant :JuuryouDentouB
  end
end
