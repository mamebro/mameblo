require 'spec_helper'

describe EntryHasHashtag do
  let(:brother) { create(:brother) }
  let(:entry) { create(:entry, brother: brother) }
  let(:hashtag) { Hashtag.create(name: 'テスト') }

  subject { EntryHasHashtag.new(entry: entry, hashtag: hashtag) }

  it { is_expected.to respond_to(:entry) }
  it { is_expected.to respond_to(:hashtag) }

  it 'is valid with entry and hashtag' do
    expect(subject).to be_valid
  end

  it 'belongs to entry' do
    association = EntryHasHashtag.create(entry: entry, hashtag: hashtag)
    expect(association.entry).to eq(entry)
  end

  it 'belongs to hashtag' do
    association = EntryHasHashtag.create(entry: entry, hashtag: hashtag)
    expect(association.hashtag).to eq(hashtag)
  end
end
