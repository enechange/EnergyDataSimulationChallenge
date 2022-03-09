# frozen_string_literal: true

require_relative '../calculator'

class Company
  class TokyoGasu
    NAME = '東京ガス'

    include Calculator

    private attr_reader :ampere, :watt

    def initialize(ampere:, watt:)
      @ampere = ampere
      @watt   = watt
      @plan_list = [ZuttomoDenki.new]
    end

    def simulate_list
      @plan_list.map do |plan|
        {
          provider_name: NAME,
          plan_name: plan.name,
          price: calculate(ampere:, watt:, basic_charge: plan.basic_charge,
                           electricity_charge: plan.electricity_charge)
        }
      end
    end

    class ZuttomoDenki
      NAME = 'ずっとも電気１'

      BASIC_CHARGE = {
        30 => '858.00',
        40 => '1144.00',
        50 => '1430.00',
        60 => '1716.00'
      }.freeze

      ELECTRICITY_CHARGE = {
        1..140 => '23.67',
        141..350 => '23.88',
        351.. => '26.41'
      }.freeze

      attr_reader :name, :basic_charge, :electricity_charge

      def initialize
        @name = NAME
        @basic_charge = BASIC_CHARGE
        @electricity_charge = ELECTRICITY_CHARGE
      end
    end

    private_constant :ZuttomoDenki
  end
end
