require "spec_helper"

describe Support do
  describe "are_you_ok" do
    let(:mail) { Support.are_you_ok }

    it "renders the headers" do
      mail.subject.should eq("Are you ok")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
