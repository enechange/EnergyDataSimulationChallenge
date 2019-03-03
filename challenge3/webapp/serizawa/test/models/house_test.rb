require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  
  def setup
   @house = houses(:one)
  end

  test "should be valid" do
    assert @house.valid?
  end
  
  test "firstname should be present" do
  @house.firstname = " "
  assert_not @house.valid?
  end
  
  test "lastname should be present" do
  @house.lastname = " "
  assert_not @house.valid?
  end
  
  test "city should be present" do
  @house.city = " "
  assert_not @house.valid?
  end
  
  test "num_of_people should be present" do
 @house.num_of_people = " "
  assert_not @house.valid?
  end
  
  test "num_of_people  should be only integer" do
  @house.num_of_people = 1.1
  assert_not @house.valid?
  end
  
  test "has_child should be present" do
  @house.has_child = " "
  assert_not@house.valid?
  end

  test "has_child should be inclusion Yes or No" do
  @house.has_child = "a"
  assert_not @house.valid?
  end
  
end
