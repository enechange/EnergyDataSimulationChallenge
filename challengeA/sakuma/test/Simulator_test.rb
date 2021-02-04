require 'minitest/autorun'
require_relative '../lib/PriceList.rb'

class SimulatorTest < Minitest::Test  
  
  # 基本料金

  # 契約アンペア(A)が10Aの時
  def test_basicPriceCaluculate_10A
    priceList = PriceList.new(10, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 286, basicPrice  
  end

  # 契約アンペア(A)が15Aの時
  def test_basicPriceCaluculate_15A
    priceList = PriceList.new(15, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 429, basicPrice  
  end

  # 契約アンペア(A)が20Aの時
  def test_basicPriceCaluculate_20A
    priceList = PriceList.new(20, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 572, basicPrice  
  end

  # 契約アンペア(A)が30Aの時
  def test_basicPriceCaluculate_30A
    priceList = PriceList.new(30, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 858, basicPrice  
  end
  
  # 契約アンペア(A)が40Aの時
  def test_basicPriceCaluculate_40A
    priceList = PriceList.new(40, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 1144, basicPrice  
  end

  # 契約アンペア(A)が50Aの時
  def test_basicPriceCaluculate_50A
    priceList = PriceList.new(50, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 1430, basicPrice  
  end

  # 契約アンペア(A)が60Aの時
  def test_basicPriceCaluculate_60A
    priceList = PriceList.new(60, rand)
    basicPrice = priceList.basicPriceCaluculate
    assert_equal 1716, basicPrice  
  end
  
  # 電気料金(契約アンペア(A)は30Aで固定)
  
  # 契約アンペア(A)= 30 , 使用量(kWh) = 120の時
  def test_simulate_120kwh
    priceList = PriceList.new(30, 120)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal 3243, priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal 3168, priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal 3698, priceList.tokyo_gas_Price.floor
  end

  # 契約アンペア(A)= 30 , 使用量(kWh) = 121の時
  def test_simulate_121kwh
    priceList = PriceList.new(30, 121)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal 3270, priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal 3194, priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal 3722, priceList.tokyo_gas_Price.floor
  end

  # 契約アンペア(A)= 30 , 使用量(kWh) = 140の時
  def test_simulate_140kwh
    priceList = PriceList.new(30, 140)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal (3773.2).floor , priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal (3696).floor , priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal (4171.8).floor , priceList.tokyo_gas_Price.floor
  end

  # 契約アンペア(A)= 30 , 使用量(kWh) = 141の時
  def test_simulate_141kwh
    priceList = PriceList.new(30, 141)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal (3773.2 + 26.48).floor , priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal (3696 + 26.40).floor , priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal (4171.8 + 23.88).floor , priceList.tokyo_gas_Price.floor
  end
  
  # 契約アンペア(A)= 30 , 使用量(kWh) = 300の時
  def test_simulate_300kwh
    priceList = PriceList.new(30, 300)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal 8010, priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal 7920, priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal 7992, priceList.tokyo_gas_Price.floor
  end

  # 契約アンペア(A)= 30 , 使用量(kWh) = 301の時
  def test_simulate_301kwh
    priceList = PriceList.new(30, 301)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal 8040, priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal 7946, priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal 8016, priceList.tokyo_gas_Price.floor
  end

  # 契約アンペア(A)= 30 , 使用量(kWh) = 350の時
  def test_simulate_350kwh
    priceList = PriceList.new(30, 350)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal (9538.5).floor , priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal (9240).floor , priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal (9186.6).floor , priceList.tokyo_gas_Price.floor
  end

  # 契約アンペア(A)= 30 , 使用量(kWh) = 351の時
  def test_simulate_351kwh
    priceList = PriceList.new(30, 351)
    # 東京電力エナジーパートナー 従量電灯B
    assert_equal (9538.5 + 30.57).floor , priceList.tepco_Price.floor
    # Looopでんきおうちプラン
    assert_equal (9240 + 26.40).floor , priceList.looop_Price.floor
    # 東京ガスずっとも電気１
    assert_equal (9186.6 + 26.41).floor , priceList.tokyo_gas_Price.floor
  end

end
