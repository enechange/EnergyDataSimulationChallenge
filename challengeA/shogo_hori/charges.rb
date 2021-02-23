class Charges
  attr_reader :amps, :usage
  require 'csv'

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def tepco
    basicCharge = basicCharge(CSV.read('./csv/tepco/basicCharge.csv'))
    usageCharge = usageUnitCharge(CSV.read('./csv/tepco/usageCharge.csv'))
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  def looop
    basicCharge = basicCharge(CSV.read('./csv/looop/basicCharge.csv'))
    usageCharge = usageUnitCharge(CSV.read('./csv/looop/usageCharge.csv'))
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  def tokyo_gas
    basicCharge = basicCharge(CSV.read('./csv/tokyo_gas/basicCharge.csv'))
    usageCharge = usageUnitCharge(CSV.read('./csv/tokyo_gas/usageCharge.csv'))
    amount = @usage.round
    (basicCharge + usageCharge * amount).floor
  end

  # def 【会社名】
  #   basicCharge = basicCharge(CSV.read('./csv/【会社名】/basicCharge.csv'))
  #   usageCharge = usageUnitCharge(CSV.read('./csv/【会社名】/usageCharge.csv'))
  #   basicCharge + usageCharge * @usage
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
