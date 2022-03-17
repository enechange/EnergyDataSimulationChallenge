# frozen_string_literal: true

require 'bigdecimal'

module Calculator
  def calculate(ampere:, kwh:, basic_charge:, electricity_charge:)
    return '契約不可なアンペア数のため、合計値は表示されません。' if basic_charge_price(ampere, basic_charge).nil?

    (BigDecimal(@basic_charge_price) + electricity_charge_price(kwh, electricity_charge)).to_i
  end

  private

  def basic_charge_price(ampere, basic_charge)
    @basic_charge_price ||= basic_charge[ampere]
  end

  def electricity_charge_price(kwh, electricity_charge)
    return 0 if kwh == 0

    total = BigDecimal('0')

    electricity_charge.each do |range, unit_price|
      if range.include?(kwh)
        total += ((range.first..kwh).size * BigDecimal(unit_price))

        break
      end

      total += (range.size * BigDecimal(unit_price))
    end

    total.to_i
  end
end
