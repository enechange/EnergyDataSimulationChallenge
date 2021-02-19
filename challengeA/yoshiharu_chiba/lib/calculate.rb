# frozen_string_literal: true

class Calculate
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  # 東京電力
  def tokyo_denryoku_plan
    (tokyo_denryoku_amps_price + tokyo_denryoku_amount_price).floor.to_s
  end

  # Looopでんき
  def looop_plan
    (@amount_per_month * 26.40).floor.to_s
  end

  # 東京ガス
  def tokyo_gas_plan
    (tokyo_gas_amps_price + tokyo_gas_amount_price).floor.to_s
  end

  # 新規電力会社
  # def test_plan
  #   ().floor.to_s
  # end

  private

  def tokyo_denryoku_amps_price
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

  def tokyo_denryoku_amount_price
    case @amount_per_month
    when 0..120 then @amount_per_month * 19.88
    when 121..300 then 120 * 19.88 + (@amount_per_month - 120) * 26.48
    else 120 * 19.88 + 180 * 26.48 + (@amount_per_month - 300) * 30.57
    end
  end

  def tokyo_gas_amps_price
    case @amps
    when 30 then 858
    when 40 then 1144
    when 50 then 1430
    else 1716
    end
  end

  def tokyo_gas_amount_price
    case @amount_per_month
    when 0..140 then @amount_per_month * 23.67
    when 141..350 then 140 * 23.67 + (@amount_per_month - 140) * 23.88
    else 140 * 23.67 + 210 * 23.88 + (@amount_per_month - 350) * 26.41
    end
  end
end
