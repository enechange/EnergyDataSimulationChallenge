require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get chart" do
    get pages_chart_url
    assert_response :success
  end

end
