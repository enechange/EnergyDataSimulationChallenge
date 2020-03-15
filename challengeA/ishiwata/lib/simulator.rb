class Simulator

  attr_reader :ampere, :usage

  def initialize(args)
    @ampere = args[:ampere]
    @usage = args[:usage]
  end

  def simulate
    if check
     simulator = Plan.new(ampere: ampere, usage: usage)
     simulator.show_plan
   else
     notice
   end
  end

  def check
    ampere.is_a?(Integer) && usage.is_a?(Integer)
  end

  def notice
    "契約アンペアと電気使用量は整数を入力してください。(例) 契約アンペア : 30 電気使用量 : 120"
  end

end
