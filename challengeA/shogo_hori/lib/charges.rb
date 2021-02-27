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

  def tokyogas
    basicCharge = basicCharge(Plan::TOKYOGAS[:basicChargeList])
    usageCharge = usageUnitCharge(Plan::TOKYOGAS[:usageChargeList])
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

  def basicCharge(list)
    basicChargeList = list.map { |n| n.map(&:to_f) }
    basicChargeList.find { |charge| charge[0] == @amps }[1]
  end

  def usageUnitCharge(list)
    usageChargeList = list.map { |n| n.map(&:to_f) }
    if @usage.zero?
      @usage
    elsif usageChargeList.last[0] >= @usage
      usageChargeList.find { |charge| charge[0] < @usage && charge[1] >= @usage }[2]
    else
      usageChargeList.last[2]
    end
  end
end
