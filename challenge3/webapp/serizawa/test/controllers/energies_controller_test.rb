require 'test_helper'

class EnergiesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @energy = energies(:one)
  end
  
  test "new_energy_urlにgetアクセスすると成功するか" do
    get new_energy_url
    assert_response :success
  end
  
  test "showアクションを存在しないenergy_idで実行するとリダイレクトされるか" do
    get energy_url(3)
    assert_redirected_to energies_url
  end
  
  test "editアクションを存在しないenergy_idで実行するとリダイレクトされるか" do
    get edit_energy_url(3)
    assert_redirected_to energies_url 
  end
  
  test "updateアクションを存在しないenergy_idで実行するとリダイレクトされるか" do
    patch energy_url(3)
    assert_redirected_to energies_url
  end

  test "destroyアクションを存在しないenergy_idで実行すると、削除が実行されず、リダイレクトされるか" do
    assert_no_difference 'Energy.count' do
      delete energy_url(3)
    end
    assert_redirected_to energies_url 
  end

end
