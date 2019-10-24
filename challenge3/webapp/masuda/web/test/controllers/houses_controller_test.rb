require 'test_helper'

class HousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @house = houses(:one)
  end

  test "should get index" do
    get houses_url, as: :json
    assert_response :success
  end

  test "should create house" do
    assert_difference('House.count') do
      post houses_url, params: { house: { city: @house.city, firstname: @house.firstname, has_child: @house.has_child, lastname: @house.lastname, num_of_people: @house.num_of_people } }, as: :json
    end

    assert_response 201
  end

  test "should show house" do
    get house_url(@house), as: :json
    assert_response :success
  end

  test "should update house" do
    patch house_url(@house), params: { house: { city: @house.city, firstname: @house.firstname, has_child: @house.has_child, lastname: @house.lastname, num_of_people: @house.num_of_people } }, as: :json
    assert_response 200
  end

  test "should destroy house" do
    assert_difference('House.count', -1) do
      delete house_url(@house), as: :json
    end

    assert_response 204
  end
end
