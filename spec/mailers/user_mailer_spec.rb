require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before do
    @user = create(:user)
    @user.reset_token  = User.new_token
  end

  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(@user) }
    let(:mail_body) { mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }

    it "renders the headers" do
      expect(mail.subject).to eq("Fallery アカウントの有効化")
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(["info@fallery.com"])
    end

    it "renders the body" do
      expect(mail_body).to match(@user.name)
      expect(mail_body).to match(@user.activation_token)
      expect(mail_body).to match(CGI.escape(@user.email))
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset(@user) }
    let(:mail_body) { mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }

    it "renders the headers" do
      expect(mail.subject).to eq("Fallery パスワードの再設定")
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(["info@fallery.com"])
    end

    it "renders the body" do
      expect(mail_body).to match(@user.reset_token)
      expect(mail_body).to match(CGI.escape(@user.email))
    end
  end

end
