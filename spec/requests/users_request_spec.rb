require 'rails_helper'

RSpec.describe "Users", type: :request do
  before do
    @user = create(:user)
  end

  describe "ユーザーの詳細ページ" do
    it "200レスポンスがかえってきたらOK" do
      get "/#{@user.name}"
      expect(response).to have_http_status 200
    end
  end
end
