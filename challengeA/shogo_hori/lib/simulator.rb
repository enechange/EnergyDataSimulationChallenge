require './shogo_hori/lib/charges.rb'

class Simulator
  attr_reader :amps, :usage, :company

  def initialize(amps, usage, company)
    @amps = amps
    @usage = usage
    @company = company
  end

  def simulate
    a = Charges.new(@amps, @usage)
    a.tepco
  end
end

simulator = Simulator.new(30, 435, 'tepco')
puts simulator.simulate
