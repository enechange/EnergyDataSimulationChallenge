require 'test_helper'

class EnergiesIndexTest < ActionDispatch::IntegrationTest

  def setup
    @energy = energies(:one)
  end

  test "energies_data(/energies)ページに関するテスト" do
    get energies_path
    assert_template 'energies/index'
    assert_match "label", response.body
    assert_match "house", response.body
    assert_match "year", response.body
    assert_match "month", response.body
    assert_match "temperature", response.body
    assert_match "daylight", response.body
    assert_match "energy_production", response.body
    assert_match "1", response.body
    assert_match "2", response.body
    assert_match "2011", response.body
    assert_match "4", response.body
    assert_match "10.5", response.body
    assert_match "4.56", response.body
    assert_match "7", response.body
    assert_select "a[href=?]", energy_path(@energy.id), count: 2 
    assert_select "a[href=?]", edit_energy_path(@energy.id)
    #新規データ作成    
    get new_energy_path      
    assert_difference 'Energy.count', 1 do 
      post energies_path, params: { energy: { label: 0,
                                              house_id: 1,
                                              year: 2011,
                                              month: 	7,
                                              temperature: 26.2	,
                                              daylight: 178.9	,
                                              energy_production: 	740} } 
    end
    follow_redirect!
    #きちんと作成されたか判定
    assert_match "0", response.body
    assert_match "1", response.body
    assert_match "2011", response.body
    assert_match "7", response.body
    assert_match "26.2", response.body
    assert_match "178.9", response.body
    assert_match "740", response.body
    #データ更新
    get edit_energy_path(Energy.last)      
    patch energy_path(Energy.last), params: { energy: { energy_production: 330} } 
    follow_redirect!
    #きちんと更新されたか判定
    assert_match "330", response.body
    #データ削除
    get houses_path      
    assert_difference 'Energy.count', -1 do 
      delete energy_path(Energy.last)
    end
    follow_redirect!
     #きちんと削除されたか判定
    assert_no_match "330", response.body
  end
end
