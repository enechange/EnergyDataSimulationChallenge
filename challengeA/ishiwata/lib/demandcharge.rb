
class DemandCharge
  attr_reader :ampere

  def initialize(ampere)
    @ampere = ampere
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


end
