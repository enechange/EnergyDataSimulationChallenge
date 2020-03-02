require 'rails_helper'

describe EnergiesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    context 'ログインしている場合' do
      before do
        login user
      end
      it "投稿ページを表示する" do
        get :new
        expect(response).to render_template :new
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end