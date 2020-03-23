
class EnergyCharge
  attr_reader :usage

  PLAN = ["従量電灯B", "おうちプラン", "ずっとも電気1"]
  CHARGE = ["tokyo_energy", "looop_energy", "tokyogas_energy"]

  def initialize(usage)
    @usage = usage
  end

  def choose_plan(plan_name)
    plan = PLAN.index(plan_name)
    self.send(CHARGE[plan])
  end


  def tokyo_energy
    energy_charge =
      if usage > 300
        30.57 * (usage - 300) + 26.48 * 180 + 19.88 * 120
      elsif usage > 120
        26.48 * (usage - 120) + 19.88 * 120
      else
        19.88 * usage
      end
    energy_charge.floor
  end

  def looop_energy
    energy_charge = usage * 26.4
    energy_charge.floor
  end

  def tokyogas_energy
    energy_charge =
      if usage > 350
        26.41 * (usage - 350) + 23.88 * 210 + 23.67 * 140
      elsif usage > 140
        23.88 * (usage - 140) + 23.67 * 140
      else
        23.67 * usage
      end
    energy_charge.floor
  end



end
