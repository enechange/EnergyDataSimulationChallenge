
class DemandCharge
  PLAN = ["従量電灯B", "おうちプラン", "ずっとも電気1"]
  CHARGE = ["tokyo_demand", "looop_demand", "tokyogas_demand"]
  attr_reader :ampere

  def initialize(ampere)
    @ampere = ampere
  end

  def choose_plan(plan_name)
    plan = PLAN.index(plan_name)
    self.send(CHARGE[plan])
  end

  def tokyo_demand
    case ampere
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
    else
      nil
    end
  end

  def looop_demand
    0
  end

  def tokyogas_demand
    case ampere
    when 30
      858
    when 40
      1144
    when 50
      1430
    when 60
      1716
    else
      nil
    end
  end

end
