require "spec_helper"

describe Support do
  describe "are_you_ok" do
    let(:mail) { Support.are_you_ok("to@example.org") }

    it "renders the headers" do
      mail.subject.should eq("ブラザーからお便りが届きました")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["info@mamebro.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(/\?\?\? 元気かな \?\?\?/)
    end
  end

end
