require "spec_helper"

describe ScoreMailer do
  describe "daily" do
    let(:mail) { ScoreMailer.daily }

    it "renders the headers" do
      expect(mail.subject).to match /【まめぶろ】Daily スコアレポート/
      mail.to.should eq(["dev@mamebro.com"])
      mail.from.should eq(["score@mamebro.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match /!!! まめぶろ Daily スコアレポート !!!/
    end
  end

end
