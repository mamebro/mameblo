require 'spec_helper'

feature 'ハッシュタグ検索' do

  let(:brother) { FactoryGirl.create(:brother) }

  before do
    FactoryGirl.create(:entry, title: '!!!foo!!!', content: '!!!foo!!!! #foo ')
    sign_in brother
  end

  scenario '#foo のみ表示されること' do
    visit hashtag_path('foo')
    expect(has_content?('!!!foo!!!! #foo')).to be_truthy
    expect(has_content?('コンテンツ: 日記の本文だよー')).to be_falsey
  end

  scenario '#fo の場合は表示されないこと' do
    visit hashtag_path('fo')
    expect(has_content?('!!!foo!!!! #foo')).to be_falsey
    expect(has_content?('コンテンツ: 日記の本文だよー')).to be_falsey
  end
end
