require 'spec_helper'

describe Hashtag do
  let(:hashtag) { Hashtag.create(name: 'テスト') }

  it { is_expected.to respond_to(:name) }

  it 'is valid with a name' do
    expect(hashtag).to be_valid
  end

  describe 'associations' do
    let(:brother) { create(:brother) }
    let(:entry) { create(:entry, brother: brother, content: '#テスト') }

    it 'has many entries through entry_has_hashtags' do
      EntryHasHashtag.create(hashtag: hashtag, entry: entry)
      expect(hashtag.entries).to include(entry)
    end

    it 'has many entry_has_hashtags' do
      association = EntryHasHashtag.create(hashtag: hashtag, entry: entry)
      expect(hashtag.entry_has_hashtags).to include(association)
    end
  end
end
