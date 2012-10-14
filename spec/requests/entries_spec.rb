# -*- coding: utf-8 -*-
require 'spec_helper'

describe "Entries" do

  subject { page }

  describe "サインインしたとき" do
    let(:brother) { FactoryGirl.create(:brother) }
    let(:entry) { FactoryGirl.create(:entry) }
    before do
      visit root_path
      sign_in brother
    end

    it '日記が投稿できること' do
      click_link '書く'
      fill_in 'entry_title', with: '日記のタイトルです!!!'
      fill_in 'textarea', with: 'こんにちは、本文です。'
      click_button '投稿'
      redirect_to brothers_path
      should have_content 'ぶろぐ投稿できたね'
      redirect_to brother
      should have_content 'Edit'
      should have_content 'Delete'
    end

    it '日記を削除できること' do
      click_link '書く'
      fill_in 'entry_title', with: '日記のタイトルです!!!'
      fill_in 'textarea', with: 'こんにちは、本文です。'
      click_button '投稿'
      redirect_to brothers_path
      click_link 'Delete'
      should have_content '日記を消したぜブラザー'
    end

    it '日記を編集できること' do
      click_link '書く'
      fill_in 'entry_title', with: '日記のタイトルです!!!'
      fill_in 'textarea', with: 'こんにちは、本文です。'
      click_button '投稿'
      redirect_to brothers_path
      click_link 'Edit'
      click_button '投稿'
      should have_content '!!! 編集完了したね !!!'
    end
  end
end
