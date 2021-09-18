# frozen_string_literal: true

require 'minitest/autorun'
require '../src/plan'
require 'json'

# display plan info test
class PlanTest < Minitest::Test
  def setup
    File.open("../data/plans.json") do |f|
      @plans = JSON.load(f)
    end
    @tokyo_energy = Plan.new(@plans['suppliers'][0])
    @looop = Plan.new(@plans['suppliers'][1])
    @tokyo_gas = Plan.new(@plans['suppliers'][2])
    @jxtg = Plan.new(@plans['suppliers'][3])
  end

  def test_tokyo_energy_basic_price
    assert_equal 286, @tokyo_energy.basic_price(10)
    assert_equal 429, @tokyo_energy.basic_price(15)
    assert_equal 572, @tokyo_energy.basic_price(20)
    assert_equal Plan::Message::NO_BASIC_PRICE, @tokyo_energy.basic_price(25)
    assert_equal 858, @tokyo_energy.basic_price(30)
    assert_equal 1144, @tokyo_energy.basic_price(40)
    assert_equal 1430, @tokyo_energy.basic_price(50)
    assert_equal 1716, @tokyo_energy.basic_price(60)
    assert_equal Plan::Message::NO_BASIC_PRICE, @tokyo_energy.basic_price(61)
  end

  def test_loops_basic_price
    assert_equal 0, @looop.basic_price(10)
    assert_equal 0, @looop.basic_price(20)
    assert_equal 0, @looop.basic_price(30)
    assert_equal 0, @looop.basic_price(40)
    assert_equal 0, @looop.basic_price(50)
    assert_equal 0, @looop.basic_price(60)
    assert_equal Plan::Message::NO_BASIC_PRICE, @looop.basic_price(61)
  end

  def test_tokyo_gas_basic_price
    assert_equal 858, @tokyo_gas.basic_price(30)
    assert_equal 1144, @tokyo_gas.basic_price(40)
    assert_equal 1430, @tokyo_gas.basic_price(50)
    assert_equal 1716, @tokyo_gas.basic_price(60)
    assert_equal Plan::Message::NO_BASIC_PRICE, @tokyo_gas.basic_price(20)
  end

  def test_jxtg_basic_price
    assert_equal 858, @jxtg.basic_price(30)
    assert_equal 1144, @jxtg.basic_price(40)
    assert_equal 1430, @jxtg.basic_price(50)
    assert_equal 1716.80, @jxtg.basic_price(60)
    assert_equal Plan::Message::NO_BASIC_PRICE, @jxtg.basic_price(20)
  end

end
