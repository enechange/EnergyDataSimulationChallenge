require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  def setup
    @house = House.new(firstname: "Carolyn",
                       lastname: "Flores",
                       city: "London",
                       num_of_people: 2,
                       has_child: true)
  end
  
  # For setup data
  test "should be valid" do
    assert @house.valid?
  end
  
  # For firstname
  test "firstname should be present" do
    @house.firstname = "   "
    assert_not @house.valid?
  end
  
  # For lastname
  test "lastname should be present" do
    @house.lastname = "   "
    assert_not @house.valid?
  end
  
  # For city
  test "city should be present" do
    @house.city = "   "
    assert_not @house.valid?
  end
  
  # For num_of_people
  test "num_of_people should be present" do
    @house.num_of_people = "   "
    assert_not @house.valid?
  end
  
  test "num_of_people should be numerical" do
    @house.num_of_people = "string"
    assert_not @house.valid?
  end
  
  test "num_of_people should be integer" do
    @house.num_of_people = 1.5
    assert_not @house.valid?
  end
  
  # For has_child
  # test "has_child should be boolean" do
  #   @house.has_child = "string"
  #   assert_not @house.valid?
  # end
end
