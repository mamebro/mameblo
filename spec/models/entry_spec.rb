require 'spec_helper'

describe Entry do

  let(:brother) { create(:brother) }

  before do
    @entry = brother.entries.build(title: "まめぶろ最高",
                                   content: "ここに本文を書いてるよブラザー！")
    subject { @entry }
  end

  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:brother_id) }
  it { is_expected.to respond_to(:brother) }

  describe "#hashtag_names" do
    it "returns hashtag names" do
      @entry = brother.entries.build(title: "まめぶろ最高",
                                     content: 'foo barハッシュタグのテスト #foo #bar')
      expect(@entry.hashtag_names).to match_array(['foo', 'bar'])
    end

    it "returns 2 hashtags when combine #foo and #bar" do
      @entry = brother.entries.build(title: "まめぶろ最高",
                                     content: 'foo barハッシュタグのテスト #foo#bar')
      expect(@entry.hashtag_names).to match_array(['foo', 'bar'])
    end

    it "returns 2 hashtag names when foo and fo" do
      @entry = brother.entries.build(title: "まめぶろ最高",
                                     content: 'foo barハッシュタグのテスト #foo #fo')
      expect(@entry.hashtag_names).to match_array(['foo', 'fo'])
    end

    it "returns nothing when markdown h1 or h2 elements" do
      @entry = brother.entries.build(title: "まめぶろ最高",
                                     content: '# foo
                                               ## bar
                                               foo barハッシュタグのテスト')
      expect(@entry.hashtag_names).to match_array([])
    end

    it "returns nothing when symbol" do
      @entry = brother.entries.build(title: "まめぶろ最高",
                                     content: 'foo barハッシュタグのテスト #$$$')
      expect(@entry.hashtag_names).to match_array([])
    end

    it "returns nothing when symbol" do
      @entry = brother.entries.build(title: "まめぶろ最高",
                                     content: 'foo barハッシュタグのテスト #テスト #２０１４')
      expect(@entry.hashtag_names).to match_array(['テスト', '２０１４'])
    end
  end

  describe "when brother_id is not present" do
    before { @entry.brother_id = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with blank content" do
    before { @entry.content = " " }
    it { is_expected.not_to be_valid }
  end

  describe "with content that is too long" do
    before { @entry.content = "a" * 100000 }
    it { is_expected.not_to be_valid }
  end

  describe "with blank title" do
    before { @entry.title = " " }
    it { is_expected.not_to be_valid }
  end

  describe "with content that is too long" do
    before { @entry.title = "a" * 100000 }
    it { is_expected.not_to be_valid }
  end

  describe "before validation" do
    describe "when blank title" do
      before { @entry.title = "" }
      it "insert today's title" do
        expect(@entry.save).to be_truthy
        entry = Entry.find @entry.id
        expect(entry.title).to eq(Date.today.strftime("%Y/%m/%d"))
      end
    end

    describe "when white space title" do
      before { @entry.title = "   " }
      it "insert today's title" do
        expect(@entry.save).to be_truthy
        entry = Entry.find @entry.id
        expect(entry.title).to eq(Date.today.strftime("%Y/%m/%d"))
      end
    end

    describe "when title is characters" do
      before { @entry.title = "YO! BRO!" }
      it "doesn't insert today's title" do
        expect(@entry.save).to be_truthy
        entry = Entry.find @entry.id
        expect(entry.title).to eq("YO! BRO!")
      end
    end
  end
end
