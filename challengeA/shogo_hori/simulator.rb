require './charges'

class Simulator
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def simulate
    charge = Charges.new(@amps, @usage)
    plans = []
    plans << { provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: "#{charge.tepco}" }
    plans << { provider_name: 'Looopでんき', plan_name: 'おうちでんきプラン', price: "#{charge.looop}" }
    plans << { provider_name: '東京ガス', plan_name: 'ずっとも電気１', price: "#{charge.tokyo_gas}" } if [30, 40, 50, 60].include?(@amps)

    plans.each do |plan|
      puts plan
    end
  end
end

simulator = Simulator.new(40, 180)
simulator.simulate
