require 'test_helper'

class EnergiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @energy = energies(:one)
  end

  test "should get index" do
    get energies_url
    assert_response :success
  end

  test "should get new" do
    get new_energy_url
    assert_response :success
  end

  test "should create energy" do
    assert_difference('Energy.count') do
      post energies_url, params: { energy: { daylight: @energy.daylight, energy_production: @energy.energy_production, house_id: @energy.house_id, label: @energy.label, month: @energy.month, temperature: @energy.temperature, year: @energy.year } }
    end

    assert_redirected_to energy_url(Energy.last)
  end

  test "should show energy" do
    get energy_url(@energy)
    assert_response :success
  end

  test "should get edit" do
    get edit_energy_url(@energy)
    assert_response :success
  end

  test "should update energy" do
    patch energy_url(@energy), params: { energy: { daylight: @energy.daylight, energy_production: @energy.energy_production, house_id: @energy.house_id, label: @energy.label, month: @energy.month, temperature: @energy.temperature, year: @energy.year } }
    assert_redirected_to energy_url(@energy)
  end

  test "should destroy energy" do
    assert_difference('Energy.count', -1) do
      delete energy_url(@energy)
    end

    assert_redirected_to energies_url
  end
end
