class Charges
  attr_reader :amps, :usage
  require 'csv'

  def tepco
    basicCharge = CSV.read('./shogo_hori/csv/tepco/tepcoBasicCharge.csv')
  end
end

require 'csv'
basicCharges = CSV.read('./shogo_hori/csv/tepco/tepcoBasicCharge.csv').map(&:to_i)
p basicCharges.find{|charge| charge[0] == "30"}[1]
