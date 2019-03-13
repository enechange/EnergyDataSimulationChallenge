require 'test_helper'

class EnergiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get energies_new_url
    assert_response :success
  end

end
