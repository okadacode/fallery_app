require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe "バリデーション" do
    it "nameとemail、nicknameに値が設定されていればOK" do
      expect(@user.valid?).to eq(true)
    end

    it "nameが空だとNG" do
      @user.name = ""
      expect(@user.valid?).to eq(false)
    end

    it "nameが17文字以上だとNG" do
      @user.name = "a" * 17
      expect(@user.valid?).to eq(false)
    end

    it "nameが有効なフォーマットであればOK" do
      valid_names = %w[test1 TEST1 testUser 123TEST]
      valid_names.each do |valid_name|
        @user.name = valid_name
        expect(@user.valid?).to eq(true)
      end
    end

    it "nameが無効なフォーマットであればNG" do
      invalid_names = %w[test/1 test_1 test-1 テスト1 てすとa]
      invalid_names.each do |invalid_name|
        @user.name = invalid_name
        expect(@user.valid?).to eq(false)
      end
    end

    it "nameが一意であればOK（大文字小文字は区別しない）" do
      duplicate_user = @user.dup
      duplicate_user.name = @user.name.upcase
      @user.save
      expect(duplicate_user.valid?).to eq(false)
    end

    it "emailが空だとNG" do
      @user.email = ""
      expect(@user.valid?).to eq(false)
    end

    it "emailが255文字以上だとNG" do
      @user.email = "a" * 244 + "@example.com"
      expect(@user.valid?).to eq(false)
    end

    it "emailが有効なフォーマットであればOK" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user.valid?).to eq(true)
      end
    end

    it "emailが無効なフォーマットであればNG" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user.valid?).to eq(false)
      end
    end

    it "emailが一意であればOK（大文字小文字は区別しない）" do
      duplicate_user = @user.dup
      duplicate_user.email = @user.email.upcase
      @user.save
      expect(duplicate_user.valid?).to eq(false)
    end

    it "nicknameが空だとNG" do
      @user.nickname = ""
      expect(@user.valid?).to eq(false)
    end

    it "nicknameが33文字以上だとNG" do
      @user.nickname = "a" * 33
      expect(@user.valid?).to eq(false)
    end

    it "passwordが空文字であればNG" do
      @user.password = @user.password_confirmation = " " * 8
      expect(@user.valid?).to eq(false)
    end

    it "passwordが8文字未満であればNG" do
      @user.password = @user.password_confirmation = "a" * 7
      expect(@user.valid?).to eq(false)
    end
  end

  describe "メソッド" do
    it "authenticated?でダイジェストが存在しなければfalse" do
      expect(@user.authenticated?(:remember, "")).to eq(false)
    end
  end
end
