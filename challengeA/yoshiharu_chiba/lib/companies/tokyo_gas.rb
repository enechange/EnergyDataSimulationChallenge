# frozen_string_literal: true

class TokyoGas
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  def tokyo_gas_plan
    tokyo_gas_amps_price = check_amps
    tokyo_gas_amount_price = check_amounts
    (tokyo_gas_amps_price + tokyo_gas_amount_price).floor
  end

  private

  def check_amps
    case @amps
    when 30 then 858
    when 40 then 1144
    when 50 then 1430
    else 1716
    end
  end

  def check_amounts
    case @amount_per_month
    when 0..140 then @amount_per_month * 23.67
    when 141..350 then 140 * 23.67 + (@amount_per_month - 140) * 23.88
    else 140 * 23.67 + 210 * 23.88 + (@amount_per_month - 350) * 26.41
    end
  end
end
