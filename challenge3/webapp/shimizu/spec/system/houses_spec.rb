require 'rails_helper'

RSpec.feature 'Houses', type: :system do
  given!(:house_1) { create(:house_1) }
  given!(:house_2) { create(:house_2) }

  background do
    visit root_path
  end

  scenario 'title表示確認' do
    expect(page).to have_title 'TOP - Challenge 3'
  end

  scenario 'ページタイトル表示確認'do
    expect(page).to have_content 'Energy Data Simulation Challenge3'
  end

  scenario '各家庭の詳細ページへのリンクがありアクセスできること' do
    within '.table' do
      page.has_link? house_path(house_1.id)
    end

    click_link 'Detail', match: :first
    expect(page).to have_content "Comparison of energy production between #{house_1.first_name}'s house and overall average"
  end
end
