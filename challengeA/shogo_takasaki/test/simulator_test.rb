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
    assert_equal [], @simulator.simulate
  end
end
