require 'csv'

class Simulator
  attr_reader :amps, :usage, :company

  def initialize(amps, usage, company)
    @amps = amps
    @usage = usage
    @company = company
  end

  def simulate
    @amps + @usage
  end
end

simulator = Simulator.new(30, 435, 'tepco')
puts simulator.simulate
