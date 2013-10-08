require 'spec_helper'

describe "Entries" do

  subject { page }

  describe "サインインして日記を投稿するとき" do
    let(:brother) { FactoryGirl.create(:brother) }
    let(:entry) { FactoryGirl.create(:entry) }
    before do
      visit root_path
      sign_in brother
      click_link '書く'
      fill_in 'entry-form-title', with: '日記のタイトル'
      fill_in 'entry-form-content', with: 'こんにちは、本文です。'
      click_button '投稿'
    end

    it '日記が投稿できること' do
      should have_content 'ぶろぐ投稿できたね'
      should have_content '日記'
      should have_content '人兄弟'
      should have_content '保護者'
    end

    it '日記を削除できること' do
      click_link '日記のタイトル'
      click_link 'Delete'
      should have_content '日記を消したぜブラザー'
    end

    it '日記を編集できること' do
      click_link '日記のタイトル'
      click_link 'Edit'
      click_button '投稿'
      should have_content '!!! 編集完了したね !!!'
    end
  end
end
