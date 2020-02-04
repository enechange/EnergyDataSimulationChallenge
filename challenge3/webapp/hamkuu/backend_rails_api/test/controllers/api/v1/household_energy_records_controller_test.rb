require 'test_helper'

class Api::V1::HouseholdEnergyRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_household_energy_records_index_url
    assert_response :success
  end

end
