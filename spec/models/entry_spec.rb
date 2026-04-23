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

  describe "associations" do
    it "belongs to brother" do
      expect(@entry.brother).to eq(brother)
    end

    it "has many beans" do
      @entry.save
      Bean.create(entry: @entry, throw_brother_id: brother.id)
      expect(@entry.beans.count).to eq(1)
    end

    it "destroys beans when entry is destroyed" do
      @entry.save
      Bean.create(entry: @entry, throw_brother_id: brother.id)
      expect { @entry.destroy }.to change(Bean, :count).by(-1)
    end

    it "has many hashtags through entry_has_hashtags" do
      @entry.save
      hashtag = Hashtag.create(name: 'テスト')
      EntryHasHashtag.create(entry: @entry, hashtag: hashtag)
      expect(@entry.hashtags).to include(hashtag)
    end
  end

  describe "#content_as_markdown" do
    it "renders markdown content as HTML" do
      @entry.content = "**bold text**"
      result = @entry.content_as_markdown
      expect(result).to include("<strong>bold text</strong>")
    end

    it "renders links with autolink" do
      @entry.content = "http://example.com"
      result = @entry.content_as_markdown
      expect(result).to include('<a href="http://example.com"')
    end

    it "renders fenced code blocks" do
      @entry.content = "```\ncode here\n```"
      result = @entry.content_as_markdown
      expect(result).to include("<code>")
    end

    it "renders strikethrough" do
      @entry.content = "~~deleted~~"
      result = @entry.content_as_markdown
      expect(result).to include("<del>deleted</del>")
    end

    it "renders tables" do
      @entry.content = "| Header |\n|--------|\n| Cell   |"
      result = @entry.content_as_markdown
      expect(result).to include("<table>")
    end
  end

  describe ".from_brothers_followed_by" do
    let(:followed_brother) { create(:brother) }
    let(:unfollowed_brother) { create(:brother) }

    before do
      brother.save
      brother.follow!(followed_brother)
    end

    let!(:own_entry) { create(:entry, brother: brother) }
    let!(:followed_entry) { create(:entry, brother: followed_brother) }
    let!(:unfollowed_entry) { create(:entry, brother: unfollowed_brother) }

    it "includes own entries" do
      expect(Entry.from_brothers_followed_by(brother)).to include(own_entry)
    end

    it "includes followed brother entries" do
      expect(Entry.from_brothers_followed_by(brother)).to include(followed_entry)
    end

    it "excludes unfollowed brother entries" do
      expect(Entry.from_brothers_followed_by(brother)).not_to include(unfollowed_entry)
    end
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
