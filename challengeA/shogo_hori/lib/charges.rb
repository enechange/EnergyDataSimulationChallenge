class Charges
  attr_reader :amps, :usage
  require 'csv'

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def tepco
    basicCharge = basicCharge(CSV.read('./shogo_hori/csv/tepco/basicCharge.csv'))
    usageCharge = usageUnitCharge(CSV.read('./shogo_hori/csv/tepco/usageCharge.csv'))
    (basicCharge + usageCharge * @usage).floor
  end

  def looop
    basicCharge = basicCharge(CSV.read('./shogo_hori/csv/looop/basicCharge.csv'))
    usageCharge = usageUnitCharge(CSV.read('./shogo_hori/csv/looop/usageCharge.csv'))
    (basicCharge + usageCharge * @usage).floor
  end

  def tokyo_gas
    basicCharge = basicCharge(CSV.read('./shogo_hori/csv/tokyo_gas/basicCharge.csv'))
    usageCharge = usageUnitCharge(CSV.read('./shogo_hori/csv/tokyo_gas/usageCharge.csv'))
    (basicCharge + usageCharge * @usage).floor
  end

  # def 【会社名】
  #   basicCharge = basicCharge(CSV.read('./shogo_hori/csv/【会社名】/basicCharge.csv'))
  #   usageCharge = usageUnitCharge(CSV.read('./shogo_hori/csv/【会社名】/usageCharge.csv'))
  #   basicCharge + usageCharge * @usage
  # end

  private

  def basicCharge(basicChargeList)
    basicChargeList = basicChargeList.map{|a|a.map{|a|a.to_f}}
    basicCharge = basicChargeList.find{|charge| charge[0] == @amps}[1]
  end

  def usageUnitCharge(usageChargeList)
    usageChargeList = usageChargeList.map{|a|a.map{|a|a.to_f}}
    usageChargeList.find{|charge| charge[0] < @usage && charge[1] >= @usage } [2]
  end
end

# require 'csv'
# basicCharges = CSV.read('./shogo_hori/csv/tepco/basicCharge.csv')
# basicCharges = basicCharges.map{|a|a.map{|a|a.to_f}}
# p basicCharges.find{|charge| charge[0] == 30}[1]

# usageCharges = CSV.read('./shogo_hori/csv/tepco/usageCharge.csv')
# usageCharges = usageCharges.map{|a|a.map{|a|a.to_f}}
# p usageCharges.find{|charge| charge[0] < 160 && charge[1] > 160 } [2]

# charges = Charges.new(30, 180)
# p charges.looop
