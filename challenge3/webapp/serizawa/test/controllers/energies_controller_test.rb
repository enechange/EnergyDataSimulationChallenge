require 'test_helper'

class EnergiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_energy_url
    assert_response :success
  end

end
