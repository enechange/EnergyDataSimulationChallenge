require 'test_helper'

class HousesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @house = houses(:one)
  end
  
  test "new_house_urlにgetアクセスすると成功するか" do
    get new_house_url
    assert_response :success
  end
  
  test "showアクションを存在しないhouse_idで実行するとリダイレクトされるか" do
    get house_url(3)
    assert_redirected_to root_url 
  end
  
  test "editアクションを存在しないhouse_idで実行するとリダイレクトされるか" do
    get edit_house_url(3)
    assert_redirected_to root_url 
  end
  
  test "updateアクションを存在しないhouse_idで実行するとリダイレクトされるか" do
    patch house_url(3)
    assert_redirected_to root_url 
  end

  test "destroyアクションを存在しないhouse_idで実行すると、削除が実行されず、リダイレクトされるか" do
    assert_no_difference 'House.count' do
      delete house_url(3)
    end
    assert_redirected_to root_url 
  end

end
