class Simulator

  attr_reader :ampere, :usage, :plans

  def initialize(args)
    @ampere = args[:ampere]
    @usage = args[:usage]
  end

  def simulation
     simulator = Plan.new(ampere: ampere, usage: usage)
     simulator.show_plan
  end

end
