require 'test_helper'

class EnergyTest < ActiveSupport::TestCase
  
  def setup
   @energy = energies(:one)
  end

  test "should be valid" do
    assert @energy.valid?
  end
  
  test "label should be present" do
  @energy.label = " "
  assert_not @energy.valid?
  end
  
  test "label should be only integer" do
  @energy.label = 1.1
  assert_not @energy.valid?
  end
  
  test "house_id should be present" do
  @energy.house_id = " "
  assert_not @energy.valid?
  end
  
  test "house_id should be only integer" do
  @energy.house_id = 1.1
  assert_not @energy.valid?
  end
  
    test "year should be present" do
  @energy.year = " "
  assert_not @energy.valid?
  end
  
  test "year should be only integer" do
  @energy.year = 1.1
  assert_not @energy.valid?
  end
  
  test "month should be present" do
  @energy.month = " "
  assert_not @energy.valid?
  end
  
  test "month should be only integer" do
  @energy.month = 1.1
  assert_not @energy.valid?
  end
  
  test "temperature should be present" do
  @energy.temperature = " "
  assert_not @energy.valid?
  end
  
  test "temperature should be numerical" do
  @energy.temperature = "a"
  assert_not @energy.valid?
  end
  
    test "daylight should be present" do
  @energy.daylight = " "
  assert_not @energy.valid?
  end
  
  test "daylight should be numerical" do
  @energy.daylight = "a"
  assert_not @energy.valid?
  end
  
  test "energy_production should be present" do
  @energy.energy_production = " "
  assert_not @energy.valid?
  end
  
  test "energy_production should be only integer" do
  @energy.energy_production = 1.1
  assert_not @energy.valid?
  end
  
end
