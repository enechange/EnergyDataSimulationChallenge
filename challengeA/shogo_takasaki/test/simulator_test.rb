# frozen_string_literal: true

require 'minitest/autorun'
require '../src/plan'
require '../src/simulator'
require 'json'

# Simulator for electric usage test
class SimulatorTest < Minitest::Test

  def setup
    @simulator = Simulator.new(60, 400)
  end

  def test_simulate
    result = [
      {
        provider_name: "東京電力エナジーパートナー",
        plan_name: "従量電灯B",
        price: 15338.4
      },
      {
        provider_name: "Looopでんき",
        plan_name: "おうちプラン", price: 11616.0
      },
      {
        provider_name: "東京ガス",
        plan_name: "ずっとも電気１",
        price: 13508.0
      },
      {
        provider_name: "JXTGでんき",
        plan_name: "従量電灯B たっぷりプラン",
        price: 12923.68
      }
    ]
    assert_equal result, @simulator.simulate
  end

end
