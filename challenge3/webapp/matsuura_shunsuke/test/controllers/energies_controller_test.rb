require 'test_helper'

class EnergiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get energies_index_url
    assert_response :success
  end

end
