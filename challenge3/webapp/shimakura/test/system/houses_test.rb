require "application_system_test_case"

class HousesTest < ApplicationSystemTestCase
  setup do
    @house = houses(:one)
  end

  test "visiting the index" do
    visit houses_url
    assert_selector "h1", text: "Houses"
  end

  test "creating a House" do
    visit houses_url
    click_on "New House"

    fill_in "City", with: @house.city
    fill_in "Firstname", with: @house.firstname
    fill_in "Has child", with: @house.has_child
    fill_in "Lastname", with: @house.lastname
    fill_in "Num of people", with: @house.num_of_people
    click_on "Create House"

    assert_text "House was successfully created"
    click_on "Back"
  end

  test "updating a House" do
    visit houses_url
    click_on "Edit", match: :first

    fill_in "City", with: @house.city
    fill_in "Firstname", with: @house.firstname
    fill_in "Has child", with: @house.has_child
    fill_in "Lastname", with: @house.lastname
    fill_in "Num of people", with: @house.num_of_people
    click_on "Update House"

    assert_text "House was successfully updated"
    click_on "Back"
  end

  test "destroying a House" do
    visit houses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "House was successfully destroyed"
  end
end
