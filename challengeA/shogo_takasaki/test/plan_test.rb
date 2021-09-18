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
    assert_equal 858, @tokyo_energy.basic_price(30)
    assert_equal 1144, @tokyo_energy.basic_price(40)
    assert_equal 1430, @tokyo_energy.basic_price(50)
    assert_equal 1716, @tokyo_energy.basic_price(60)
    e = assert_raises RuntimeError do @tokyo_energy.basic_price(61) end
    assert_equal Plan::Message::NO_BASIC_PRICE, e.message
  end

  def test_loops_basic_price
    assert_equal 0, @looop.basic_price(10)
    assert_equal 0, @looop.basic_price(20)
    assert_equal 0, @looop.basic_price(30)
    assert_equal 0, @looop.basic_price(40)
    assert_equal 0, @looop.basic_price(50)
    assert_equal 0, @looop.basic_price(60)
    e = assert_raises RuntimeError do @looop.basic_price(61) end
    assert_equal Plan::Message::NO_BASIC_PRICE, e.message
  end

  def test_tokyo_gas_basic_price
    assert_equal 858, @tokyo_gas.basic_price(30)
    assert_equal 1144, @tokyo_gas.basic_price(40)
    assert_equal 1430, @tokyo_gas.basic_price(50)
    assert_equal 1716, @tokyo_gas.basic_price(60)
    e = assert_raises RuntimeError do @tokyo_gas.basic_price(20) end
    assert_equal Plan::Message::NO_BASIC_PRICE, e.message
  end

  def test_jxtg_basic_price
    assert_equal 858, @jxtg.basic_price(30)
    assert_equal 1144, @jxtg.basic_price(40)
    assert_equal 1430, @jxtg.basic_price(50)
    assert_equal 1716.80, @jxtg.basic_price(60)
    e = assert_raises RuntimeError do @jxtg.basic_price(20) end
    assert_equal Plan::Message::NO_BASIC_PRICE, e.message
  end

  def test_tokyo_energy_unit_price
    assert_equal 19.88, @tokyo_energy.unit_price(0)
    assert_equal 19.88, @tokyo_energy.unit_price(119)
    assert_equal 19.88, @tokyo_energy.unit_price(120)
    assert_equal 26.48, @tokyo_energy.unit_price(121)
    assert_equal 26.48, @tokyo_energy.unit_price(300)
    assert_equal 30.57, @tokyo_energy.unit_price(301)
    assert_equal 30.57, @tokyo_energy.unit_price(400)
  end

  def test_loops_unit_price
    assert_equal 26.40, @looop.unit_price(0)
    assert_equal 26.40, @looop.unit_price(119)
    assert_equal 26.40, @looop.unit_price(120)
    assert_equal 26.40, @looop.unit_price(121)
    assert_equal 26.40, @looop.unit_price(300)
    assert_equal 26.40, @looop.unit_price(301)
    assert_equal 26.40, @looop.unit_price(400)
  end

  def test_tokyo_gas_unit_price
    assert_equal 23.67, @tokyo_gas.unit_price(0)
    assert_equal 23.67, @tokyo_gas.unit_price(139)
    assert_equal 23.67, @tokyo_gas.unit_price(140)
    assert_equal 23.88, @tokyo_gas.unit_price(141)
    assert_equal 23.88, @tokyo_gas.unit_price(349)
    assert_equal 23.88, @tokyo_gas.unit_price(350)
    assert_equal 26.41, @tokyo_gas.unit_price(351)
  end

  def test_jxtg_unit_price
    assert_equal 19.88, @jxtg.unit_price(0)
    assert_equal 19.88, @jxtg.unit_price(120)
    assert_equal 26.48, @jxtg.unit_price(121)
    assert_equal 26.48, @jxtg.unit_price(300)
    assert_equal 25.08, @jxtg.unit_price(301)
    assert_equal 25.08, @jxtg.unit_price(600)
    assert_equal 26.15, @jxtg.unit_price(601)
  end

  def test_additional_price
    assert_equal 0, @tokyo_energy.additional_price(0)
    assert_equal 19.88 * 119, @tokyo_energy.additional_price(119)
    assert_equal 19.88 * 120, @tokyo_energy.additional_price(120)
    assert_equal 26.48 * 121, @tokyo_energy.additional_price(121)
    assert_equal 26.48 * 300, @tokyo_energy.additional_price(300)
    assert_equal 30.57 * 301, @tokyo_energy.additional_price(301)
    assert_equal 30.57 * 400, @tokyo_energy.additional_price(400)

    assert_equal 19.88 * 0, @jxtg.additional_price(0)
    assert_equal 19.88 * 120, @jxtg.additional_price(120)
    assert_equal 26.48 * 121, @jxtg.additional_price(121)
    assert_equal 26.48 * 300, @jxtg.additional_price(300)
    assert_equal 25.08 * 301, @jxtg.additional_price(301)
    assert_equal 25.08 * 600, @jxtg.additional_price(600)
    assert_equal 26.15 * 601, @jxtg.additional_price(601)
  end

  def test_price
    assert_equal 0 + 286.00, @tokyo_energy.price(10, 0)
    assert_equal 429 + 19.88 * 119, @tokyo_energy.price(15, 119)
    assert_equal 572 + 19.88 * 120, @tokyo_energy.price(20, 120)
    assert_equal 858 + 26.48 * 121, @tokyo_energy.price(30, 121)
    assert_equal 1144 + 26.48 * 300, @tokyo_energy.price(40, 300)
    assert_equal 1430 + 30.57 * 301, @tokyo_energy.price(50, 301)
    assert_equal 1716 + 30.57 * 400, @tokyo_energy.price(60, 400)

    assert_equal 858 + 19.88 * 0, @jxtg.price(30, 0)
    assert_equal 858 + 19.88 * 120, @jxtg.price(30, 120)
    assert_equal 1144 + 26.48 * 121, @jxtg.price(40, 121)
    assert_equal 1144 + 26.48 * 300, @jxtg.price(40, 300)
    assert_equal 1430 + 25.08 * 301, @jxtg.price(50, 301)
    assert_equal 1716.80 + 25.08 * 600, @jxtg.price(60, 600)
    assert_equal 1716.80 + 26.15 * 601, @jxtg.price(60, 601)
  end
end
