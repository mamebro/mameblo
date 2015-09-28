require "spec_helper"

describe BrotherMailer do
  describe "password_reset" do
    let(:brother) { create(:brother) }
    let(:mail) { BrotherMailer.password_reset(brother) }

    it "renders the headers" do
      expect(mail.subject).to eq("【まめぶろ】パスワード再設定")
      expect(mail.to).to eq([brother.email])
      expect(mail.from).to eq(["info@mamebro.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match (/パスワードを再設定/)
    end
  end

end
