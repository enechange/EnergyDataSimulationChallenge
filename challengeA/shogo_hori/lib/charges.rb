require_relative './plan'

class Charges
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def tepco
    basicCharge = basicCharge(Plan::TEPCO[:basicChargeList])
    usageCharge = usageUnitCharge(Plan::TEPCO[:usageChargeList])
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  def looop
    basicCharge = basicCharge(Plan::LOOOP[:basicChargeList])
    usageCharge = usageUnitCharge(Plan::LOOOP[:usageChargeList])
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  def tokyo_gas
    basicCharge = basicCharge(Plan::TOKYO_GAS[:basicChargeList])
    usageCharge = usageUnitCharge(Plan::TOKYO_GAS[:usageChargeList])
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  # def 【company】
  #   basicCharge = basicCharge(Plan::【COMPANY】[:basicChargeList])
  #   usageCharge = usageUnitCharge(Plan::【COMPANY】[:usageChargeList])
  #   amount = @usage.round
  #   (basicCharge + usageCharge * amount).floor
  # end

  private

  def basicCharge(basicChargeList)
    basicChargeList = basicChargeList.map{|a|a.map{|a|a.to_f}}
    basicCharge = basicChargeList.find{|charge| charge[0] == @amps}[1]
  end

  def usageUnitCharge(usageChargeList)
    usageChargeList = usageChargeList.map{|a|a.map{|a|a.to_f}}
    if @usage == 0
      usageCharge = 0
    elsif usageChargeList.last[0] >= @usage
      usageCharge = usageChargeList.find { |charge| charge[0] < @usage && charge[1] >= @usage }[2]
    else
      usageCharge = usageChargeList.last[2]
    end
  end
end
