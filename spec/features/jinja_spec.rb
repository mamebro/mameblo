require 'spec_helper'

feature 'Jinja' do

  subject { page }

  feature "サインインしている時" do
    let(:brother) { FactoryGirl.create(:brother) }

    before do
      @brother =  FactoryGirl.create(:brother)
      sign_in brother
      visit root_path
      visit jinja_path
    end

    scenario '神社ページが表示されること' do
      is_expected.to have_content '神社'
      is_expected.to have_content '屋台'
      is_expected.to have_content 'まめくじ'
    end

    scenario '日記を投稿できること' do
      fill_in 'entry-form-title', with: '日記のタイトル'
      fill_in 'entry-form-content', with: 'こんにちは、本文です。'
      click_button '投稿'
      is_expected.to have_content 'ぶろぐ投稿できたね'
    end
  end
end
