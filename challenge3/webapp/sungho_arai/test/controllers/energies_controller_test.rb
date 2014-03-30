require 'test_helper'

class EnergiesControllerTest < ActionController::TestCase
  setup do
    @energy = energies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:energies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create energy" do
    assert_difference('Energy.count') do
      post :create, energy: { daylight: @energy.daylight, energy_production: @energy.energy_production, house_id: @energy.house_id, label: @energy.label, month: @energy.month, temperature: @energy.temperature, year: @energy.year }
    end

    assert_redirected_to energy_path(assigns(:energy))
  end

  test "should show energy" do
    get :show, id: @energy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @energy
    assert_response :success
  end

  test "should update energy" do
    patch :update, id: @energy, energy: { daylight: @energy.daylight, energy_production: @energy.energy_production, house_id: @energy.house_id, label: @energy.label, month: @energy.month, temperature: @energy.temperature, year: @energy.year }
    assert_redirected_to energy_path(assigns(:energy))
  end

  test "should destroy energy" do
    assert_difference('Energy.count', -1) do
      delete :destroy, id: @energy
    end

    assert_redirected_to energies_path
  end
end
