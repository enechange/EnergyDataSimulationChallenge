require 'rails_helper'

feature 'power_consumption', type: :feature do
  let(:user) { create(:user) }
  let!(:city) { create(:city) }

  scenario '新規投稿処理のテスト' do
    expect{
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      find('.send-btn').click
      expect(current_path).to eq root_path

      click_link('消費電力データ')
      expect(current_path).to eq new_power_consumption_path
      fill_in 'power_consumption[power_consumption]', with: 1200
      fill_in 'power_consumption[year]', with: 2013
      fill_in 'power_consumption[month]', with: 6
      find(".send-btn").click
    }.to change(PowerConsumption, :count).by(1)
  end
end