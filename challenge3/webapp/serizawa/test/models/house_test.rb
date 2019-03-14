require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  
  def setup
   @house = houses(:one)
  end

  test "サニティーチェック" do
    assert @house.valid?
  end
  
  test "firstname は存在しなければならない" do
  @house.firstname = " "
  assert_not @house.valid?
  end
  
  test "lastname は存在しなければならない" do
  @house.lastname = " "
  assert_not @house.valid?
  end
  
  test "city は存在しなければならない" do
  @house.city = " "
  assert_not @house.valid?
  end
  
  test "num_of_people は存在しなければならない" do
 @house.num_of_people = " "
  assert_not @house.valid?
  end
  
  test "num_of_people は小数点は受け付けない" do
  @house.num_of_people = 1.1
  assert_not @house.valid?
  end
  
  test "has_child は存在しなければならない" do
  @house.has_child = " "
  assert_not@house.valid?
  end

  test "has_child should はYesかNoしか受け付けない" do
  @house.has_child = "a"
  assert_not @house.valid?
  end
  
end
