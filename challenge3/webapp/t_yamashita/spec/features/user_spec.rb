require 'rails_helper'

feature 'user', type: :feature do
  let(:user) { create(:user) }
  let!(:city) { create(:city) }

  scenario 'ログイン処理のテスト' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('.send-btn').click
    expect(current_path).to eq root_path
  end

  scenario '新規登録処理のテスト' do
    expect{
      visit new_user_registration_path
      fill_in 'user[firstname]', with: 'テスト'
      fill_in 'user[lastname]', with: 'テスト'
      fill_in 'user[email]', with: 'xyz@example.com'
      fill_in 'user[password]', with: '1a1a1a'
      fill_in 'user[password_confirmation]', with: '1a1a1a' 
      select '日本', from: 'user[city_id]'
      find('.send-btn').click
    }.to change(User, :count).by(1)
  end

  scenario 'アカウント編集機能のテスト' do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('.send-btn').click
    expect(current_path).to eq root_path

    click_link('アカウント編集')
    expect(current_path).to eq edit_user_registration_path
    fill_in 'user[firstname]', with: 'テストテスト'
    fill_in 'user[lastname]', with: 'bbb'
    fill_in 'user[email]', with: 'abc@example.com'
    fill_in 'user[password]', with: '1a1a1a'
    fill_in 'user[password_confirmation]', with: '1a1a1a' 
    fill_in 'user[current_password]', with: '1a1a1a'
    select '日本', from: 'user[city_id]'
    find('.send-btn').click
    expect(current_path).to eq root_path
    expect(page).to have_content('テストテスト')
  end

  scenario 'アカウント削除のテスト' do
    expect {
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      find('.send-btn').click     
      expect(current_path).to eq root_path
      click_link('アカウント削除')
    }.to change(User, :count).by(1)
  end
end