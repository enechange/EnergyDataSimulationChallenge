require 'test_helper'

class HousesIndexTest < ActionDispatch::IntegrationTest

  def setup
    @house = houses(:one)
  end

  test "houses_data(rootページ)ページに関するテスト" do
    get root_path
    assert_template 'houses/index'
    assert_match "yamada", response.body
    assert_match "firstname", response.body
    assert_match "lastname", response.body
    assert_match "city", response.body
    assert_match "num_of_people", response.body
    assert_match "has_child", response.body
    assert_match "yamada", response.body
    assert_match "taro", response.body
    assert_match "London", response.body
    assert_match "1", response.body
    assert_match "No", response.body
    assert_select "a[href=?]", house_path(@house.id), count: 2 
    assert_select "a[href=?]", edit_house_path(@house.id)
    #新規データ作成    
    get new_house_path      
    assert_difference 'House.count', 1 do 
      post houses_path, params: { house: { firstname: "テスト用firstname",
                                            lastname: "テスト用lastname",
                                            city: "Cambridge",
                                            num_of_people: 2,
                                            has_child: "Yes" } } 
    end
    follow_redirect!
    #きちんと作成されたか判定
    assert_match "テスト用firstname", response.body
    assert_match "テスト用lastname", response.body
    assert_match "Cambridge", response.body
    assert_match "2", response.body
    assert_match "Yes", response.body
    #データ更新
    get edit_house_path(House.last)      
    patch house_path(House.last), params: { house: { firstname: "更新テスト用firstname"} } 
    follow_redirect!
    #きちんと更新されたか判定
    assert_match "更新テスト用firstname", response.body
    #データ削除
    get houses_path      
    assert_difference 'House.count', -1 do 
      delete house_path(House.last)
    end
    follow_redirect!
     #きちんと削除されたか判定
    assert_no_match "テスト用firstname", response.body
  end
end
