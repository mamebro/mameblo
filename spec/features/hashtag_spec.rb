require 'spec_helper'

feature 'ハッシュタグ検索' do

  let(:brother) { FactoryGirl.create(:brother) }

  before do
    sign_in brother
    fill_in 'entry-form-title', with: 'テスト'
    fill_in 'entry-form-content', with: 'テスト #test #foo'
    click_on '!!! 投稿 !!!'
  end

  scenario '#foo のエントリーが表示されること' do
    visit hashtag_path('foo')
    expect(has_content?('テスト #test #foo')).to be_truthy
  end

  scenario '#test のエントリーが表示されること' do
    visit hashtag_path('test')
    expect(has_content?('テスト #test #foo')).to be_truthy
  end

  scenario 'fo で #fooのエントリーは表示されないこと' do
    visit hashtag_path('fo')
    expect(has_content?('!!!foo!!!! #foo')).to be_falsey
  end

  scenario '編集'
  scenario '削除'
end
