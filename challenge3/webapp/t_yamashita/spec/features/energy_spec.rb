require 'rails_helper'

feature 'energies', type: :feature do
  let(:user) { create(:user) }
  let!(:city) { create(:city) }

  scenario '新規投稿処理のテスト' do
    expect{
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      find('.send-btn').click
      expect(current_path).to eq root_path

      click_link('エネルギー生産量データ')
      expect(current_path).to eq new_energy_path
      fill_in 'energy[energy_production]', with: 1200
      fill_in 'energy[year]', with: 2013
      fill_in 'energy[month]', with: 6
      fill_in 'energy[temperature]', with: 26.50
      fill_in 'energy[daylight]', with: 230.50
      find(".send-btn").click
    }.to change(Energy, :count).by(1)
  end
end