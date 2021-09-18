# frozen_string_literal: true

require 'minitest/autorun'
require '../src/plan'
require '../src/simulator'
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
    assert_equal @tokyo_energy.unit_price(0) * 0, @tokyo_energy.additional_price(0)
    assert_equal @tokyo_energy.unit_price(119) * 119, @tokyo_energy.additional_price(119)
    assert_equal @tokyo_energy.unit_price(120) * 120, @tokyo_energy.additional_price(120)
    assert_equal @tokyo_energy.unit_price(121) * 121, @tokyo_energy.additional_price(121)
    assert_equal @tokyo_energy.unit_price(300) * 300, @tokyo_energy.additional_price(300)
    assert_equal @tokyo_energy.unit_price(301) * 301, @tokyo_energy.additional_price(301)
    assert_equal @tokyo_energy.unit_price(400) * 400, @tokyo_energy.additional_price(400)

    assert_equal @jxtg.unit_price(0) * 0, @jxtg.additional_price(0)
    assert_equal @jxtg.unit_price(120) * 120, @jxtg.additional_price(120)
    assert_equal @jxtg.unit_price(121) * 121, @jxtg.additional_price(121)
    assert_equal @jxtg.unit_price(300) * 300, @jxtg.additional_price(300)
    assert_equal @jxtg.unit_price(301) * 301, @jxtg.additional_price(301)
    assert_equal @jxtg.unit_price(600) * 600, @jxtg.additional_price(600)
    assert_equal @jxtg.unit_price(601) * 601, @jxtg.additional_price(601)
  end

  def test_price
    assert_equal @tokyo_energy.basic_price(10) + @tokyo_energy.additional_price(0), @tokyo_energy.price(10, 0)
    assert_equal @tokyo_energy.basic_price(15) + @tokyo_energy.additional_price(119), @tokyo_energy.price(15, 119)
    assert_equal @tokyo_energy.basic_price(20) + @tokyo_energy.additional_price(120), @tokyo_energy.price(20, 120)
    assert_equal @tokyo_energy.basic_price(30) + @tokyo_energy.additional_price(121), @tokyo_energy.price(30, 121)
    assert_equal @tokyo_energy.basic_price(40) + @tokyo_energy.additional_price(300), @tokyo_energy.price(40, 300)
    assert_equal @tokyo_energy.basic_price(50) + @tokyo_energy.additional_price(301), @tokyo_energy.price(50, 301)
    assert_equal @tokyo_energy.basic_price(60) + @tokyo_energy.additional_price(400), @tokyo_energy.price(60, 400)

    assert_equal @jxtg.basic_price(30) + @jxtg.additional_price(0), @jxtg.price(30, 0)
    assert_equal @jxtg.basic_price(30) + @jxtg.additional_price(120), @jxtg.price(30, 120)
    assert_equal @jxtg.basic_price(40) + @jxtg.additional_price(121), @jxtg.price(40, 121)
    assert_equal @jxtg.basic_price(40) + @jxtg.additional_price(300), @jxtg.price(40, 300)
    assert_equal @jxtg.basic_price(50) + @jxtg.additional_price(301), @jxtg.price(50, 301)
    assert_equal @jxtg.basic_price(60) + @jxtg.additional_price(600), @jxtg.price(60, 600)
    assert_equal @jxtg.basic_price(60) + @jxtg.additional_price(601), @jxtg.price(60, 601)
  end

  def test_price_with_tax
    assert_equal @tokyo_energy.price(60, 400) + (@tokyo_energy.price(60, 400) * Simulator::TAX_RATE), @tokyo_energy.price_with_tax(60, 400)
    assert_equal @jxtg.price(30, 0) + (@jxtg.price(30, 0) * Simulator::TAX_RATE), @jxtg.price_with_tax(30, 0)
  end

  def test_display
    result_tokyo_energy = {
      provider_name: '東京電力エナジーパートナー',
      plan_name: '従量電灯B',
      price: @tokyo_energy.price_with_tax(60, 400)
    }
    assert_equal result_tokyo_energy, @tokyo_energy.display(60, 400)

    result_looops = {
      provider_name: 'Looopでんき',
      plan_name: 'おうちプラン',
      price: @looop.price_with_tax(60, 400)
    }
    assert_equal result_looops, @looop.display(60, 400)

    result_tokyo_gas = {
      provider_name: '東京ガス',
      plan_name: 'ずっとも電気１',
      price: @tokyo_gas.price_with_tax(60, 400)
    }
    assert_equal result_tokyo_gas, @tokyo_gas.display(60, 400)

    result_jxtg = {
      provider_name: 'JXTGでんき',
      plan_name: '従量電灯B たっぷりプラン',
      price: @jxtg.price_with_tax(60, 400)
    }
    assert_equal result_jxtg, @jxtg.display(60, 400)
  end
end
