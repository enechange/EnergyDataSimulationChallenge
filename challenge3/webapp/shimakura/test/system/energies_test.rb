require "application_system_test_case"

class EnergiesTest < ApplicationSystemTestCase
  setup do
    @energy = energies(:one)
  end

  test "visiting the index" do
    visit energies_url
    assert_selector "h1", text: "Energies"
  end

  test "creating a Energy" do
    visit energies_url
    click_on "New Energy"

    fill_in "Daylight", with: @energy.daylight
    fill_in "Energy production", with: @energy.energy_production
    fill_in "Label", with: @energy.label
    fill_in "Month", with: @energy.month
    fill_in "Temperature", with: @energy.temperature
    fill_in "Year", with: @energy.year
    click_on "Create Energy"

    assert_text "Energy was successfully created"
    click_on "Back"
  end

  test "updating a Energy" do
    visit energies_url
    click_on "Edit", match: :first

    fill_in "Daylight", with: @energy.daylight
    fill_in "Energy production", with: @energy.energy_production
    fill_in "Label", with: @energy.label
    fill_in "Month", with: @energy.month
    fill_in "Temperature", with: @energy.temperature
    fill_in "Year", with: @energy.year
    click_on "Update Energy"

    assert_text "Energy was successfully updated"
    click_on "Back"
  end

  test "destroying a Energy" do
    visit energies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Energy was successfully destroyed"
  end
end
