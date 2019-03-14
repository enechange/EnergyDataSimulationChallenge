require 'test_helper'

class EnergyTest < ActiveSupport::TestCase
  
  def setup
   @energy = energies(:one)
  end

  test "サニティーチェック" do
    assert @energy.valid?
  end
  
  test "label の存在性のテスト" do
  @energy.label = " "
  assert_not @energy.valid?
  end
  
  test "label は小数点を受け付けない" do
  @energy.label = 1.1
  assert_not @energy.valid?
  end
  
  test "house_idは存在しなければならない" do
  @energy.house_id = " "
  assert_not @energy.valid?
  end
  
  test "house_id は小数点を受け付けない" do
  @energy.house_id = 1.1
  assert_not @energy.valid?
  end
  
    test "year は存在しなければならない" do
  @energy.year = " "
  assert_not @energy.valid?
  end
  
  test "year は小数点を受け付けない" do
  @energy.year = 1.1
  assert_not @energy.valid?
  end
  
  test "month は存在しなければならない" do
  @energy.month = " "
  assert_not @energy.valid?
  end
  
  test "monthは小数点を受け付けない" do
  @energy.month = 1.1
  assert_not @energy.valid?
  end
  
  test "temperature は存在しなければならない" do
  @energy.temperature = " "
  assert_not @energy.valid?
  end
  
  test "temperature は数値でなければならない" do
  @energy.temperature = "a"
  assert_not @energy.valid?
  end
  
    test "daylight は存在しなければならない" do
  @energy.daylight = " "
  assert_not @energy.valid?
  end
  
  test "daylightは数値でなければならない" do
  @energy.daylight = "a"
  assert_not @energy.valid?
  end
  
  test "energy_production は存在しなければならない" do
  @energy.energy_production = " "
  assert_not @energy.valid?
  end
  
  test "energy_production は小数点を受け付けない" do
  @energy.energy_production = 1.1
  assert_not @energy.valid?
  end
  
end
