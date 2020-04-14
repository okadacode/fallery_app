require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  before do
    @user = create(:user)
  end

  describe "ユーザー登録ページ" do
    it "200レスポンスがかえってきたらOK" do
      get login_path
      expect(response).to have_http_status 200
    end

    it "ユーザー登録失敗時にフラッシュが表示されたらOK" do
      get login_path
      post login_path, params: { session: { email: "",
                                            password: "" } }
      expect(response).to render_template "sessions/new"
      expect(flash[:danger]).to be_truthy
      get root_path
      expect(flash[:danger]).to be_falsey
    end

    it "ログイン成功からログアウトまで" do
      get login_path
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      expect(session[:user_id]).to be_truthy
      follow_redirect!
      expect(response).to render_template "users/show"
      delete logout_path
      expect(session[:user_id]).to be_falsey
      delete logout_path
      follow_redirect!
      expect(response).to render_template "top_pages/home"
    end

    it "remember_meをオンにしたとき" do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password,
                                            remember_me: "1" } }
      expect(@user.reload.remember_digest).to be_truthy
    end

    it "remember_meをオフにしたとき" do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password,
                                            remember_me: "1" } }
      delete logout_path
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password,
                                            remember_me: "0" } }
      expect(@user.reload.remember_digest).to be_falsey
    end
  end

end
