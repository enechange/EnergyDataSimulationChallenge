require 'test_helper'

class HousesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get houses_index_url
    assert_response :success
  end

end
