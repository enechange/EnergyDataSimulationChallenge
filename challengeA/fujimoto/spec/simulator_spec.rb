require './lib/simulator'

RSpec.describe do
  it '東京電力エナジーパートナーの従量電灯Bプラン：40A, 100kWhの電力量で3132円' do
    simulator = Simulator.new(40, 100)
    plan_a = simulator.simulate.find{ |plan| 
      plan[:provider_name] == "東京電力エナジーパートナー" &&
      plan[:plan_name] == "従量電灯B"
    }

    expect(plan_a[:price]).to eq 3132
  end

  it '東京ガスのずっとも電気1プラン：40A, 100kWhの電力量で3132円' do
    simulator = Simulator.new(40, 100)
    plan_b = simulator.simulate.find{ |plan|
      plan[:provider_name] == "東京ガス" &&
      plan[:plan_name] == "ずっとも電気1"
    }
    expect(plan_b[:price]).to eq 3511
  end
end