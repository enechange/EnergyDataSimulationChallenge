require 'rails_helper'

RSpec.feature 'Houses', type: :system do
  given!(:house_1) { create(:house_1) }

  background do
    visit root_path
  end

  scenario 'TOPページにタイトルバーが表示されていること' do
    expect(page).to have_title 'TOP - Challenge 3'
  end

  scenario 'TOPページにタイトルが表示されていること' do
    expect(page).to have_content 'Energy Data Simulation Challenge3'
  end

  scenario 'TOPページのテーブルにリンクがあり各家庭の詳細ページにアクセスできること' do
    within '.table' do
      page.has_link? house_path(house_1.id)
    end

    all('table tr').last.click_link 'Detail'
    expect(page).to have_content "Comparison of energy production between #{house_1.first_name}'s house and overall average"
  end
end
