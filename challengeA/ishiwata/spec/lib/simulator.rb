
require 'spec_helper'
require 'simulator'

describe "Simulator" do
  it "is initialized"  do

    simulation = Simulator.new(40, 280)

    expect(simulation.ampere).to eq(40)
    expect(simulation.usage).to eq(280)
  end

  it "is simulated" do

    simulation = Simulator.new(40, 280)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 7766},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 7392},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: 7801}
       ])
  end


end
