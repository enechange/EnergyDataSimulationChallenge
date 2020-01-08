require 'test_helper'

class Api::V1::HouseOwnersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_house_owners_index_url
    assert_response :success
  end

end
