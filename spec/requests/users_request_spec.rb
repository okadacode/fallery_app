require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = create(:user)
    @another = create(:another)
  end

  describe "ユーザーの詳細ページ" do
    it "200レスポンスがかえってきたらOK" do
      get "/#{@user.name}"
      expect(response).to have_http_status 200
    end
  end

  describe "ユーザー登録失敗時のテスト" do
    it "ユーザーの数が変わっていないかつ、newテンプレートが表示されたらOK" do
      get signup_path
      expect {
        post signup_path, params: { user:
                                    { name: "",
                                      email: "valid@example",
                                      nickname: "",
                                      password: "foo",
                                      password_confirmation: "bar" } }
      }.not_to change(User, :count)
      expect(response).to render_template "users/new"
    end
  end

  describe "ユーザー登録成功時のテスト" do
    it "ユーザーの数が増えるかつ、showテンプレートが表示されたらOK" do
      get signup_path
      expect {
        post signup_path, params: { user:
                                    { name: "exampleuser",
                                      email: "user@example.com",
                                      nickname: "example",
                                      password: "password",
                                      password_confirmation: "password" } }
      }.to change(User, :count).by(1)
      follow_redirect!
      expect(response).to render_template "users/show"
    end
  end

  describe "ユーザーの編集の失敗に対するテスト" do
    it "無効なデータが入力されたとき、editテンプレートが表示される" do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      get "/#{@user.name}/setting"
      expect(response).to render_template "users/edit"
      patch "/#{@user.name}/setting", params: {
                          user: { email: "foo@invalid",
                                  nickname: "",
                                  password: "foo",
                                  password_confirmation: "bar"} }
      expect(response).to render_template "users/edit"
    end
  end

  describe "ユーザーの編集が成功したときのテスト" do
    it "有効なデータが入力されたとき、データベースが更新される" do
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      get "/#{@user.name}/setting"
      expect(response).to render_template "users/edit"
      email = "foo@bar.com"
      nickname = "テスト"
      patch "/#{@user.name}/setting", params: {
                          user: { email: email,
                                  nickname: nickname,
                                  password: "",
                                  password_confirmation: ""} }
      expect(flash[:danger]).to be_falsey
      expect(response).to redirect_to "/#{@user.name}"
      @user.reload
      expect(@user.email).to eq(email)
      expect(@user.nickname).to eq(nickname)
    end
  end

  describe "ログイン済みでないとアクセスできないページのテスト" do
    it "未ログインのユーザーがeditアクションを行えるか" do
      get "/#{@user.name}/setting"
      expect(flash[:notice]).to be_truthy
      expect(response).to redirect_to login_url
    end

    it "未ログインのユーザーがupdateアクションを行えるか" do
      patch "/#{@user.name}/setting", params: {
        user: { email: @user.email,
        nickname: @user.nickname } }
      expect(flash[:notice]).to be_truthy
      expect(response).to redirect_to login_url
    end

    it "フレンドリーフォワーディングのテスト" do
      get "/#{@user.name}/setting"
      post login_path, params: { session: { email: @user.email,
                                            password: @user.password } }
      expect(response).to redirect_to "/#{@user.name}/setting"
    end
  end

  describe "ユーザーのプライベートなページのテスト" do
    it  "別のユーザーでログインしたときにeditアクションを行えるか" do
      post login_path, params: { session: { email: @another.email,
                                            password: @another.password } }
      get "/#{@user.name}/setting"
      expect(response).to redirect_to root_url
    end

    it  "別のユーザーでログインしたときにupdateアクションを行えるか" do
      post login_path, params: { session: { email: @another.email,
                                            password: @another.password } }
      patch "/#{@user.name}/setting", params: {
        user: { email: @user.email,
        nickname: @user.nickname } }
      expect(response).to redirect_to root_url
    end


  end
end
