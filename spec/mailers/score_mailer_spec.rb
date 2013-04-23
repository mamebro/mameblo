require "spec_helper"

describe ScoreMailer do
  describe "daily" do
    let(:mail) { ScoreMailer.daily }

    it "renders the headers" do
      pending("work in progress")
      mail.subject.should eq("Daily")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      pending("work in progress")
      mail.body.encoded.should match("Hi")
    end
  end

end
