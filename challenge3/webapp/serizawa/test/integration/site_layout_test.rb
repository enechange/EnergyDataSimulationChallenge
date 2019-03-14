require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "housesレイアウトのリンクに関するテスト" do
    get root_path
    assert_template 'houses/index'
    assert_select "a[href=?]", energies_path
    assert_select "a[href=?]", new_house_path
  end
  
  test "energies_dataのレイアウトのリンクに関するテスト" do
    get energies_path
    assert_template 'energies/index'
    assert_select "a[href=?]", houses_path
    assert_select "a[href=?]", new_energy_path
  end
end
