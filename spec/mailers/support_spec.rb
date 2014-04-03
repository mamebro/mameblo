require "spec_helper"

describe Support do
  describe "are_you_ok" do
    let(:mail) { Support.are_you_ok("to@example.org") }

    it "renders the headers" do
      expect(mail.subject).to eq("ブラザーからお便りが届きました")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["info@mamebro.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(/\?\?\? 元気かな \?\?\?/)
    end
  end

end
