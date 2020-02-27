
require 'spec_helper'
require 'simulator'

describe "Simulator" do
  it "is initialized"  do

    simulation = Simulator.new(40, 280)

    expect(simulation.ampere).to eq(40)
    expect(simulation.usage).to eq(280)
  end

  it "is simulated by (60 A, 360 kWh)" do

    simulation = Simulator.new(60, 360)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 10702},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 9504},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: 10308}
       ])
  end

  it "is simulated by (50 A, 320 kWh)" do

    simulation = Simulator.new(50, 320)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 9193},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 8448},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: 9042}
       ])
  end

  it "is simulated by (40 A, 280 kWh)" do

    simulation = Simulator.new(40, 280)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 7766},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 7392},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: 7801}
       ])
  end

  it "is simulated by (30 A, 150 kWh)" do

    simulation = Simulator.new(30, 150)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 4038},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 3960},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: 4410}
       ])
  end

  it "is simulated by (20 A, 100 kWh)" do

    simulation = Simulator.new(20, 100)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 2560},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 2640},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: "このプランは存在しません"}
       ])
  end

  it "is simulated by (15 A, 70 kWh)" do

    simulation = Simulator.new(15, 70)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 1820},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 1848},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: "このプランは存在しません"}
       ])
  end

  it "is simulated by (10 A,  kWh)" do

    simulation = Simulator.new(10, 210)

    expect(simulation.simulate).to eq([
       {provider_name: '東京電力エナジーパートナー', plan_name: '従量電灯B', price: 5054},
       {provider_name: 'Looopでんき', plan_name: 'おうちプラン', price: 5544},
       {provider_name: '東京ガス',plan_name: 'ずっとも電気1', price: "このプランは存在しません"}
       ])
  end


end
