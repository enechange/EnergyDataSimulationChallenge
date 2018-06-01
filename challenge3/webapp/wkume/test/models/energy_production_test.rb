require 'test_helper'

class EnergyProductionTest < ActiveSupport::TestCase
  def setup
    @house = houses(:one)
    @production_data = EnergyProduction.new(label:             0,
                                            house_id:          @house.id,
                                            year:              2011,
                                            month:             7,
                                            temperature:       26.2,
                                            daylight:          178.9,
                                            energy_production: 740)
  end
  
  # For setup data
  test "shoulde be valid" do
    assert @production_data.valid?
  end
  
  # For label
  test "label should be present" do
    @production_data.label = "   "
    assert_not @production_data.valid?
  end
  
  test "label should be numerical" do
    @production_data.label = "string"
    assert_not @production_data.valid?
  end
  
  test "label should be integer" do
    @production_data.label = 1.5
    assert_not @production_data.valid?
  end
  
  # For year
  test "year should be present" do
    @production_data.year = "   "
    assert_not @production_data.valid?
  end
  
  test "year should be numerical" do
    @production_data.year = "string"
    assert_not @production_data.valid?
  end
  
  test "year should be integer" do
    @production_data.year = 1.5
    assert_not @production_data.valid?
  end
  
  # For month
  test "month should be present" do
    @production_data.month = "   "
    assert_not @production_data.valid?
  end
  
  test "month should be numerical" do
    @production_data.month = "string"
    assert_not @production_data.valid?
  end
  
  test "month should be integer" do
    @production_data.month = 1.5
    assert_not @production_data.valid?
  end
  
  # For temperature
  test "temperature should be present" do
    @production_data.temperature = "   "
    assert_not @production_data.valid?
  end
  
  test "temperature should be numerical" do
    @production_data.temperature = "string"
    assert_not @production_data.valid?
  end
  
  # For daylight
  test "daylight should be present" do
    @production_data.daylight = "   "
    assert_not @production_data.valid?
  end
  
  test "daylight should be numerical" do
    @production_data.daylight = "string"
    assert_not @production_data.valid?
  end
  
  # For energy_production
  test "energy_production should be present" do
    @production_data.energy_production = "   "
    assert_not @production_data.valid?
  end
  
  test "energy_production should be numerical" do
    @production_data.energy_production = "string"
    assert_not @production_data.valid?
  end
  
  test "energy_production should be integer" do
    @production_data.energy_production = 1.5
    assert_not @production_data.valid?
  end
end
