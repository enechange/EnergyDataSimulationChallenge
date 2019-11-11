require 'test_helper'

class EnergyProductionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @energy_production = energy_productions(:one)
  end

  test "should get index" do
    get energy_productions_url, as: :json
    assert_response :success
  end

  test "should create energy_production" do
    assert_difference('EnergyProduction.count') do
      post energy_productions_url, params: { energy_production: { daylight: @energy_production.daylight, energy_production: @energy_production.energy_production, house_id: @energy_production.house_id, label: @energy_production.label, month: @energy_production.month, temperature: @energy_production.temperature, year: @energy_production.year } }, as: :json
    end

    assert_response 201
  end

  test "should show energy_production" do
    get energy_production_url(@energy_production), as: :json
    assert_response :success
  end

  test "should update energy_production" do
    patch energy_production_url(@energy_production), params: { energy_production: { daylight: @energy_production.daylight, energy_production: @energy_production.energy_production, house_id: @energy_production.house_id, label: @energy_production.label, month: @energy_production.month, temperature: @energy_production.temperature, year: @energy_production.year } }, as: :json
    assert_response 200
  end

  test "should destroy energy_production" do
    assert_difference('EnergyProduction.count', -1) do
      delete energy_production_url(@energy_production), as: :json
    end

    assert_response 204
  end
end
