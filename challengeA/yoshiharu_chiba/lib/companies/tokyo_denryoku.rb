# frozen_string_literal: true

class TokyoDenryoku
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  def tokyo_denryoku_plan
    tokyo_denryoku_amps_price = check_amps
    tokyo_denryoku_amount_price = check_amounts
    (tokyo_denryoku_amps_price + tokyo_denryoku_amount_price).floor
  end

  private

  def check_amps
    case @amps
    when 10 then 286
    when 15 then 429
    when 20 then 572
    when 30 then 858
    when 40 then 1144
    when 50 then 1430
    else 1716
    end
  end

  def check_amounts
    case @amount_per_month
    when 0..120 then @amount_per_month * 19.88
    when 121..300 then 120 * 19.88 + (@amount_per_month - 120) * 26.48
    else 120 * 19.88 + 180 * 26.48 + (@amount_per_month - 300) * 30.57
    end
  end
end
