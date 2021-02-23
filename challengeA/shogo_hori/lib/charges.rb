class Charges
  attr_reader :amps, :usage
  require 'csv'

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def tepco
    basicChargeList = CSV.read('./shogo_hori/csv/tepco/basicCharge.csv')
    basicChargeList = basicChargeList.map{|a|a.map{|a|a.to_i}}
    basicCharge = basicChargeList.find{|charge| charge[0] == @amps}[1]
    usageChargeList = CSV.read('./shogo_hori/csv/tepco/usageCharge.csv')
    usageChargeList = usageChargeList.map{|a|a.map{|a|a.to_i}}
    usageCharge =
    basicCharge + usageCharge * @usage
  end
end

require 'csv'
basicCharges = CSV.read('./shogo_hori/csv/tepco/basicCharge.csv')
basicCharges = basicCharges.map{|a|a.map{|a|a.to_i}}
p basicCharges.find{|charge| charge[0] == 30}[1]

usageCharges = CSV.read('./shogo_hori/csv/tepco/usageCharge.csv')
# usageCharges = usageCharges.map{|a|a.map{|a|a.to_i}}
p usageCharges.find{|charge| charge[0] < 30 < charge[1]} [2]
if 1 < 2
  puts "yes"
else
  puts "no"
end
