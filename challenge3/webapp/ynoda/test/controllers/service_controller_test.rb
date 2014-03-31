require 'test_helper'

class ServiceControllerTest < ActionController::TestCase
  test "should get listhousedata" do
    get :listhousedata
    assert_response :success
  end

  test "should get listdataset" do
    get :listdataset
    assert_response :success
  end

end
