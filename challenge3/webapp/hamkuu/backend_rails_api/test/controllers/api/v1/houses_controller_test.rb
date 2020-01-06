require 'test_helper'

class Api::V1::HousesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_houses_index_url
    assert_response :success
  end

end
