require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:energy) { create(:energy) }
  let!(:power_consumption) { create(:power_consumption) }

  describe 'GET #comparison' do
    context 'ログインしている場合' do
      before do
        login user
      end
      it "発電量比較ページを表示する" do
        get :comparison, params: {id: user.id}
        expect(response).to render_template :comparison
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get :comparison, params: {id: user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end


  describe 'GET #self_sufficiency' do
    context 'ログインしている場合' do
      before do
        login user
      end
      it "電気の自給率ページを表示する" do
        get :self_sufficiency, params: {id: user.id}
        expect(response).to render_template :self_sufficiency
      end
    end

    context 'ログインしていない場合' do
      it 'トップページにリダイレクトされる' do
        get :self_sufficiency, params: {id: user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
