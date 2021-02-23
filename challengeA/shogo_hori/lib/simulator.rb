require './shogo_hori/lib/charges.rb'

class Simulator
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  def simulate
    charge = Charges.new(@amps, @usage)
    plans = [
      { provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{charge.tepco}" },
      { provider_name: 'Looopでんき', plan_name: 'おうちでんきプラン', price: "#{charge.looop}" },
      { provider_name: '東京ガス', plan_name: 'ずっとも電気１', price: "#{charge.tokyo_gas}" }
    ]
    plans.each do |plan|
      puts plan
    end
  end
end

simulator = Simulator.new(40, 180)
simulator.simulate
puts '山の人生'
