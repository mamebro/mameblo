require 'spec_helper'

feature "Entries" do

  subject { page }

  feature "サインインして日記を投稿するとき" do
    let(:brother) { create(:brother) }
    let(:entry) { create(:entry) }

    before do
      sign_in brother
      first(:link, '兄弟').click
      fill_in 'entry-form-title', with: '日記のタイトル'
      fill_in 'entry-form-content', with: 'こんにちは、本文です。'
      click_button '投稿'
    end

    scenario '日記が投稿できること' do
      is_expected.to have_content 'ぶろぐ投稿できたね'
      is_expected.to have_content '日記'
      is_expected.to have_content '人兄弟'
      is_expected.to have_content '保護者'
    end

    scenario '日記を削除できること' do
      click_link '日記のタイトル'
      click_link 'Delete'
      is_expected.to have_content '日記を消したぜブラザー'
    end

    scenario '日記を編集できること' do
      click_link '日記のタイトル'
      click_link 'Edit'
      click_button '編集'
      is_expected.to have_content '!!! 編集完了したね !!!'
    end
  end

  feature "タイトルを入力しないで日記を投稿するとき" do
    let(:brother) { create(:brother) }
    before do
      sign_in brother
      first(:link, '兄弟').click
      fill_in 'entry-form-content', with: 'yey! タイトル無しで投稿!!!'
      click_button '投稿'
    end

    scenario 'タイトルが今日の日付になっていること' do
      is_expected.to have_content Date.today.strftime("%Y/%m/%d")
      is_expected.to have_content 'ぶろぐ投稿できたね'
    end
  end

  feature 'サインインしていない時' do
    scenario 'トップにリダイレクトされること' do
      visit timelines_brothers_path
      is_expected.to have_content 'サインイン'
      is_expected.to have_content 'はじめる'
    end
  end
end
