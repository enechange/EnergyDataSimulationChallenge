
class Simulation

  attr_reader :ampere, :usage

  def initialize(ampere, usage)
    @ampere = ampere
    @usage = usage
  end


  def simulate
    result = []

    result.push(use_tokyoenergy_plan)
    result.push(use_loop_plan)

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
        30.57 * (@usage - 300 ) + 26.48 * 180 + 26.48 + 19.88 * 120
      elsif @usage > 120
        26.48 * (@usage - 120) + 19.88 * 120
      else
        19.88 * @usage
      end

    (base_pay + add_pay).floor

  end

  def use_loop_plan

    (@usage * 26.40).floor

  end



end
