# frozen_string_literal: true

class Simulator
  attr_reader :ampere, :usage

  def initialize(ampere, usage)
    @ampere = ampere
    @usage = usage
  end

  def simulate
    result = []

    result.push(use_tokyoenergy_plan)
    result.push(use_loop_plan)
    result.push(use_tokyogas_plan)

    result
  end

  def use_tokyoenergy_plan
    base_pay =
      case @ampere
      when 10
        286
      when 15
        429
      when 20
        572
      when 30
        858
      when 40
        1144
      when 50
        1430
      when 60
        1716
      end

    add_pay =
      if @usage > 300
        30.57 * (@usage - 300) + 26.48 * 180 + 19.88 * 120
      elsif @usage > 120
        26.48 * (@usage - 120) + 19.88 * 120
      else
        19.88 * @usage
      end

    sum = (base_pay + add_pay).floor

    { provider_name: '東京電力エナジーパートナー',
      plan_name: '従量電灯B',
      price: sum }
  end

  def use_loop_plan
    sum = (@usage * 26.40).floor

    { provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: sum }
  end

  def use_tokyogas_plan
    base_pay =
      case @ampere
      when 30
        858
      when 40
        1144
      when 50
        1430
      when 60
        1716
      else
        return {
          provider_name: '東京ガス',
          plan_name: 'ずっとも電気1',
          price: 'このプランは存在しません'
        }
      end

    add_pay =
      if @usage > 350
        26.41 * (@usage - 350) + 23.88 * (350 - 140) + 23.67 * 140
      elsif @usage > 140
        23.88 * (@usage - 140) + 23.67 * 140
      else
        23.67 * @usage
      end

    sum = (base_pay + add_pay).floor

    { provider_name: '東京ガス',
      plan_name: 'ずっとも電気1',
      price: sum }
  end
end
