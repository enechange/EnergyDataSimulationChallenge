
class EnergyCharge
  attr_reader :usage

  def initialize(usage)
    @usage = usage
  end

  def tokyo_energy
    energy_charge =
      if usage > 300
        30.57 * (usage - 300) + 26.48 * 180 + 19.88 * 120
      elsif @usage > 120
        26.48 * (usage - 120) + 19.88 * 120
      else
        19.88 * usage
      end
    energy_charge.floor
  end
end
